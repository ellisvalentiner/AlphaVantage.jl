
"""
Internal function that wraps Requests.get
"""
function _get_request(uri::String)
    resp = HTTP.get(uri)
    if resp.status != 200
        #desc = STATUS_CODES[status]
        error("Expected status code 200 but received $resp.status")
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
Internal function that helps forms the request uri
"""
function _form_uri_tail(client::AVClient, outputsize, datatype)
    a = "&apikey=" * key(client)
    a = outputsize === nothing ? a : "&outputsize=$outputsize" * a
    a = datatype === nothing ? a : "&datatype=$datatype" * a

    return a
end

"""
Internal function that helps forms the request uri
"""
function _form_uri_head(client::AVClient, func)
    uri = entry(client) * "query?"
    f = "function="* uppercase(func)
    uri * f
end

function _parse_params(params)
    if isempty(params)
        return ""
    else
        args = keys(params)
        values = collect(params)
        return mapreduce(i-> "&$(args[i])=$(params[i])", *, 1:length(params)) 
    end
end
