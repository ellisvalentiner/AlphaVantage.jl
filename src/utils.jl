
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

"""
Internal function that asserts the arguments are valid for the API.
"""
function _validate_args(func::String, args)
    if func == "TIME_SERIES_INTRADAY"
        if !issubset(keys(args), [:interval, :outputsize, :datatype])
            throw(ArgumentError("Invalid argument"))
        end
        if :interval in keys(args)
            if !in(args[:interval], ["1min", "5min", "15min", "30min", "60min"])
                throw(ArgumentError("interval=$interval is not valid"))
            end
        end
        if !issubset(args[:outputsize], [:outputsize, :datatype])
            throw(ArgumentError("outputsize=$outputsize is not valid"))
        end
        if !issubset(args[:datatype], ["csv", "json"])
            throw(ArgumentError("datatype=$datatype is not valid"))
        end
    end
    if ismatch(r"TIME_SERIES_(DAILY|WEEKLY|MONTHLY)($|_ADJUSTED$)", func)
        if !issubset(keys(args), [:outputsize, :datatype])
            throw(ArgumentError("Invalid argument"))
        end
        # outputsize = get(args, :outputsize, nothing)
        # if !issubset(outputsize, ["compact", "full"])
        #     throw(ArgumentError("outputsize=$outputsize is not valid"))
        # end
        # datatype = get(args, :datatype, nothing)
        # if !issubset(datatype, ["csv", "json"])
        #     throw(ArgumentError("datatype=$datatype is not valid"))
        # end
    end
    if func == "FOREIGN_EXCHANGE_CURRENCY"
        if !issubset(args, [:from_currency, :to_currency])
            throw(ArgumentError("Invalid argument"))
        end
    end
    if ismatch(r"DIGITAL_CURRENCY_(INTRADAY|DAILY|WEEKLY|MONTHLY)$", func)
        if !issubset(args, [:market])
            throw(ArgumentError("Invalid argument"))
        end
    end
end

"""
Join together key word arguments to query string
"""
function _join_parameters(x...)
    join(join.(collect(x), "="), "&")
end

"""

"""
function _request(func::String; kwargs...)
    uri = "$(alphavantage_api)query?function=$func"
    args = Dict(kwargs)
    if length(args) > 0
        _validate_args(args)
        uri *= "&" * join(join.(collect(kwargs), "="), "&")
    end
    uri *= "&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
    data = _get_request(uri)
    return data
end
