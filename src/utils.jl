
"""
Internal function that wraps Requests.get
"""
function _get_request(uri::String)
    resp = HTTP.get(uri)
    if resp.status != 200
        desc = STATUS_CODES[status]
        error("Expected status code 200 but received $status: $desc")
    end
    return resp
end

"""
Internal function that parses the response
"""
function _parse_response(data, datatype::String)
    if datatype == "csv"
        return readdlm(data.body, ',', header=true)
    elseif datatype == "json"
        return JSON.Parser.parse(String(data.body))
    end
end

"""
set API key if the environment variable doesn't set or the "overwrite" flag set true
"""
function set_apikey(apikey::String; overwrite=true)
    envkey = "ALPHA_VANTAGE_API_KEY"
    if !haskey(ENV, envkey) | overwrite
        ENV["ALPHA_VANTAGE_API_KEY"] = apikey
    end
end

export set_apikey