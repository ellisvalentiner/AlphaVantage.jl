interval_indicators = ["VWAP", "AD", "OBV"]

for func in interval_indicators
    fname = Symbol(func)
    @eval begin
        function ($fname)(symbol::String, interval::String, datatype::String="json")
            @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min", "daily", "weekly", "monthly"])
            uri = _form_uri_head(uppercase($func)) * "&symbol=$symbol&interval=$interval&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
            data = _get_request(uri)
            return _parse_response(data, datatype)
        end
    export $fname
    end
end

interval_seriestype_indicators = ["MACD"]

for func in interval_seriestype_indicators
    fname = Symbol(func)
    @eval begin
        function ($fname)(symbol::String, interval::String, series_type::String, datatype::String="json")
            @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min", "daily", "weekly", "monthly"])
            @argcheck in(series_type, ["open", "high", "low", "close"])

            uri = _form_uri_head(uppercase($func)) * "&symbol=$symbol&interval=$interval&series_type=$series_type&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
            data = _get_request(uri)
            return _parse_response(data, datatype)
        end
    export $fname
    end
end

interval_timeperiod_indicators = ["ADX", "ADXR", "CCI", "AROON"]

for func in interval_timeperiod_indicators
    fname = Symbol(func)
    @eval begin
        function ($fname)(symbol::String, interval::String, time_period::Int64, datatype::String="json")
            @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min", "daily", "weekly", "monthly"])
            @argcheck time_period > 0
    
            uri = _form_uri_head(uppercase($func)) * "&symbol=$symbol&interval=$interval&time_period=$time_period&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
            data = _get_request(uri)
            return _parse_response(data, datatype)
        end
        export $fname
    end
end

interval_timeperiod_seriestype_indicators = ["EMA", "SMA", "WMA", "DEMA", "TEMA", "TRIMA", "KAMA", "RSI"]

for func in interval_timeperiod_seriestype_indicators
    fname = Symbol(func)
    @eval begin 
        function ($fname)(symbol::String, interval::String, time_period::Int64, series_type::String, datatype::String="json")
            @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min", "daily", "weekly", "monthly"])
            @argcheck in(series_type, ["open", "high", "low", "close"])
            @argcheck time_period > 0

            uri = _form_uri_head(uppercase($func)) * "&symbol=$symbol&interval=$interval&time_period=$time_period&series_type=$series_type&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
            data = _get_request(uri)
            return _parse_response(data, datatype)
        end
    export $fname
    end
end