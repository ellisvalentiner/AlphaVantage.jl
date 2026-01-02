"""
Exception thrown when a premium endpoint is accessed without premium API key access.
"""
struct PremiumEndpointError <: Exception
    message::String
end

Base.showerror(io::IO, e::PremiumEndpointError) = print(io, "PremiumEndpointError: ", e.message)

"""
Internal function that wraps HTTP.get
"""
function _get_request(uri::String)
    resp = HTTP.get(uri)
    _check_api_errors(resp)
    _check_status_code(resp)
    return resp
end

"""
Internal function to check whether the response contains API errors:
    - 'Note' field indicates the API limit was reached
    - 'Information' field indicates a premium endpoint requires premium access
"""
function _check_api_errors(resp::HTTP.Response)
    content_type = HTTP.header(resp, "Content-Type")
    body_str = String(resp.body)
    
    # Check if response looks like JSON (either by content-type or by content)
    is_json = content_type == "application/json" || _is_json_response(body_str)
    
    if is_json && !isempty(strip(body_str))
        try
            body = JSON.Parser.parse(IOBuffer(body_str))
            if isa(body, Dict)
                if haskey(body, "Note")
                    error("API limit exceeded")
                elseif haskey(body, "Information")
                    msg = get(body, "Information", "This endpoint requires premium API access")
                    throw(PremiumEndpointError(msg))
                end
            end
        catch e
            # If it's an error we intentionally threw, rethrow it
            if isa(e, PremiumEndpointError)
                rethrow(e)
            elseif isa(e, ErrorException)
                if occursin("API limit", e.msg)
                    rethrow(e)
                end
            end
            # Otherwise, JSON parsing failed - continue with normal parsing
            # (This allows non-JSON responses to be handled normally)
        end
    end
end

"""
Internal function to check response status code
"""
function _check_status_code(resp::HTTP.Response)
    if resp.status != 200
        error("Expected status code 200 but received $resp.status")
    end
end

"""
Helper function to check if a response body is a JSON error response
"""
function _is_json_error_response(body::String)
    try
        parsed = JSON.Parser.parse(IOBuffer(body))
        return isa(parsed, Dict) && (haskey(parsed, "Note") || haskey(parsed, "Information"))
    catch
        return false
    end
end

"""
Helper function to check if a response body looks like JSON
"""
function _is_json_response(body::String)
    # Check if body starts with '{' or '[' which are JSON indicators
    stripped = strip(body)
    return !isempty(stripped) && (startswith(stripped, '{') || startswith(stripped, '['))
end

"""
Internal function that parses the response
"""
function _parse_response(resp::HTTP.Response, datatype::Union{String, Nothing})
    if datatype == "csv"
        return readdlm(IOBuffer(resp.body), ',', header=true)
    elseif datatype == "json"
        return JSON.Parser.parse(IOBuffer(resp.body))
    else
        # When datatype is nothing (default), try to detect the format
        body_str = String(resp.body)
        
        # Check if it's empty
        if isempty(strip(body_str))
            error("Empty response received from API")
        end
        
        # Check if it's a JSON error response first
        if _is_json_error_response(body_str)
            # Parse as JSON to get proper error handling
            return JSON.Parser.parse(IOBuffer(body_str))
        elseif _is_json_response(body_str)
            # Looks like JSON but not an error - parse as JSON
            return JSON.Parser.parse(IOBuffer(body_str))
        else
            # Try CSV parsing as default, but handle errors gracefully
            try
                raw = readdlm(IOBuffer(resp.body), ',', header=true)
                return AlphaVantageResponse(raw)
            catch e
                # If CSV parsing fails, try JSON as fallback
                if isa(e, ArgumentError) || isa(e, BoundsError)
                    try
                        return JSON.Parser.parse(IOBuffer(body_str))
                    catch
                        error("Failed to parse response as CSV or JSON. Response: $(body_str[1:min(200, length(body_str))])...")
                    end
                else
                    rethrow(e)
                end
            end
        end
    end
end

"""
Internal function to build the request URI
"""
function _build_uri(scheme::String, host::String, path::String, params::Dict)
    @argcheck in(scheme, ["https", "http"])
    params = filter(p -> !isnothing(p.second), params)
    params = collect(pairs(params))
    query = join(map(p -> "$(p.first)=$(p.second)", params), "&")
    return "$(scheme)://$(host)/$(path)?$(query)"
end

_parser(p, datatype) = p
function _parser(p::AbstractString, datatype)
    if p == "default"
        return x -> _parse_response(x, datatype)
    else
        # if parser is unknown, then return raw data
        return identity
    end
end
