"""
Internal function that wraps HTTP.get
"""
function _get_request(uri::String)
    resp = HTTP.get(uri)
    _check_api_limit(resp)
    _check_status_code(resp)
    return resp
end

"""
Internal function to check whether the response contains
    'Note' that indicates the API limit was reached
"""
function _check_api_limit(resp::HTTP.Messages.Response)
    content_type = HTTP.Messages.header(resp.headers, "Content-Type")
    if content_type == "application/json"
        body = _parse_response(resp, "json")
        if haskey(body, "Note")
            error("API limit exceeded")
        end
    end
end

"""
Internal function to check response status code
"""
function _check_status_code(resp::HTTP.Messages.Response)
    if resp.status != 200
        error("Expected status code 200 but received $resp.status")
    end
end

"""
Internal function that parses the response
"""
function _parse_response(data, datatype::Union{String, Nothing})
    if datatype == "csv"
        return readdlm(data.body, ',', header=true)
    elseif datatype == "json"
        body = copy(data.body)  # TODO: re-write to avoid copying
        return JSON.Parser.parse(String(body))
    else
        raw = readdlm(data.body, ',', header=true)
        return AlphaVantageResponse(raw)
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
