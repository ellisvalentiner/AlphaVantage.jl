
"""
Internal function that wraps Requests.get
"""
function _get_request(uri::String)
    resp = Requests.get(uri)
    status = statuscode(resp)
    if status != 200
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
        return readcsv(data.data)
    elseif datatype == "json"
        return Requests.json(data)
    end
end
