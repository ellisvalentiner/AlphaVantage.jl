
"""
Internal function that wraps Requests.get
"""
function _get_request(uri::String)
    resp = HTTP.get(uri)
    if resp.status != 200
        desc = STATUS_CODES[resp.status]
        error("Expected status code 200 but received $status: $desc")
    end
    return resp
end

"""
Internal function that parses the response
"""
function _parse_response(data, datatype::String)
    if datatype == "csv"
        return readcsv(data.data)
    elseif datatype == "json"
        return JSON.parse(String(data.body))
    end
end
