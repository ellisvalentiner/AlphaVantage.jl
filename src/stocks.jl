VERSION >= v"0.6.0"

function _get(uri::String)
    resp = Requests.get(uri)
    status = statuscode(resp)
    if status != 200
        desc = STATUS_CODES[status]
        error("Expected status code 200 but received $status: $desc")
    end
    return resp.data
end

function _parse_data(data, datatype::String)
    if datatype == "csv"
        return readcsv(data)
    elseif datatype == "json"
        return Requests.json(data)
    end
end

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

function intraday(symbol::String="MSFT"; interval::String="1min", outputsize::String="compact", datatype::String="csv", apikey::String="demo")
    _validate_args(interval=interval, outputsize=outputsize, datatype=datatype)
    uri = "$(alphavantage_api)query?function=TIME_SERIES_INTRADAY&symbol=$(symbol)&interval=$(interval)&outputsize=$(outputsize)&datatype=$(datatype)&apikey=$(apikey)"
    data = _get(uri)
    return _parse_data(data, datatype)
end

function daily(symbol::String="MSFT"; outputsize::String="compact", datatype::String="csv", apikey::String="demo")
    _validate_args(outputsize=outputsize, datatype=datatype)
    uri = "$(alphavantage_api)query?function=TIME_SERIES_DAILY&symbol=$(symbol)&outputsize=$(outputsize)&datatype=$(datatype)&apikey=$(apikey)"
    data = _get(uri)
    return _parse_data(data, datatype)
end

function daily_adjusted(symbol::String="MSFT"; outputsize::String="compact", datatype::String="csv", apikey::String="demo")
    _validate_args(outputsize=outputsize, datatype=datatype)
    uri = "$(alphavantage_api)query?function=TIME_SERIES_DAILY&symbol=$(symbol)&outputsize=$(outputsize)&datatype=$(datatype)&apikey=$(apikey)"
    data = _get(uri)
    return _parse_data(data, datatype)
end

function weekly(symbol::String="MSFT"; outputsize::String="compact", datatype::String="csv", apikey::String="demo")
    _validate_args(outputsize=outputsize, datatype=datatype)
    uri = "$(alphavantage_api)query?function=TIME_SERIES_DAILY&symbol=$(symbol)&outputsize=$(outputsize)&datatype=$(datatype)&apikey=$(apikey)"
    data = _get(uri)
    return _parse_data(data, datatype)
end

function weekly_adjusted(symbol::String="MSFT"; outputsize::String="compact", datatype::String="csv", apikey::String="demo")
    _validate_args(outputsize=outputsize, datatype=datatype)
    uri = "$(alphavantage_api)query?function=TIME_SERIES_DAILY&symbol=$(symbol)&outputsize=$(outputsize)&datatype=$(datatype)&apikey=$(apikey)"
    data = _get(uri)
    return _parse_data(data, datatype)
end

function monthly(symbol::String="MSFT"; outputsize::String="compact", datatype::String="csv", apikey::String="demo")
    _validate_args(outputsize=outputsize, datatype=datatype)
    uri = "$(alphavantage_api)query?function=TIME_SERIES_DAILY&symbol=$(symbol)&outputsize=$(outputsize)&datatype=$(datatype)&apikey=$(apikey)"
    data = _get(uri)
    return _parse_data(data, datatype)
end

function monthly_adjusted(symbol::String="MSFT"; outputsize::String="compact", datatype::String="csv", apikey::String="demo")
    _validate_args(outputsize=outputsize, datatype=datatype)
    uri = "$(alphavantage_api)query?function=TIME_SERIES_DAILY&symbol=$(symbol)&outputsize=$(outputsize)&datatype=$(datatype)&apikey=$(apikey)"
    data = _get(uri)
    return _parse_data(data, datatype)
end
