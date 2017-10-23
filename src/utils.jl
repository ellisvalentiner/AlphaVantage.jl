
"""
Internal function that wraps Requests.get
"""
function _get(uri::String)
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
function _parse_data(data, datatype::String)
    if datatype == "csv"
        return readcsv(data.data)
    elseif datatype == "json"
        return Requests.json(data)
    end
end

"""
Internal function that asserts the arguments are valid for the API.
"""
function _validate_args(;kwargs...)
    args = Dict(kwargs)
    if !all(map(x->x in [:interval, :outputsize, :datatype], keys(args)))
        throw(ArgumentError("Invalid argument"))
    end

    if :interval in keys(args)
        if !in(args[:interval], ["1min", "5min", "15min", "30min", "60min"])
            throw(ArgumentError("interval=$interval is not valid"))
        end
    end

    if !in(args[:outputsize], ["compact", "full"])
        throw(ArgumentError("outputsize=$outputsize is not valid"))
    end

    if !in(args[:datatype], ["csv", "json"])
        throw(ArgumentError("datatype=$datatype is not valid"))
    end
end
