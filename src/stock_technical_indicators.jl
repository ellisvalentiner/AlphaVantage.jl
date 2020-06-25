interval_indicators = ["VWAP", "AD", "OBV", 
                       "TRANGE", "STOCH", "STOCHF", "BOP",
                       "ULTOSC", "SAR", "ADOSC"]

for func in interval_indicators
    fname = Symbol(func)
    @eval begin
        function ($fname)(symbol::String, interval::String, datatype::String="json"; kwargs...)
            @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min", "daily", "weekly", "monthly"])
            
            requiredParams = "&symbol=$symbol&interval=$interval&"
            optionalParams = _parse_params(kwargs)
            
            uri = _form_uri_head(uppercase($func)) * requiredParams * optionalParams * "&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
            data = _get_request(uri)
            return _parse_response(data, datatype)
        end
    export $fname
    end
end

interval_seriestype_indicators = ["HT_TRENDLINE", "HT_SINE", "HT_TRENDMODE",
                                  "HT_DCPERIOD", "HT_DCPHASE", "HT_PHASOR", 
                                  "MACD", "MAMA", "MACDEXT", "APO", "PPO"]

for func in interval_seriestype_indicators
    fname = Symbol(func)
    @eval begin
        function ($fname)(symbol::String, interval::String, series_type::String, datatype::String="json"; kwargs...)
            @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min", "daily", "weekly", "monthly"])
            @argcheck in(series_type, ["open", "high", "low", "close"])

            requiredParams = "&symbol=$symbol&interval=$interval&series_type=$series_type&"
            optionalParams = _parse_params(kwargs)

            uri = _form_uri_head(uppercase($func)) * requiredParams * optionalParams * "&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
            data = _get_request(uri)
            return _parse_response(data, datatype)
        end
    export $fname
    end
end

interval_timeperiod_indicators = ["ADX", "ADXR", "CCI", 
                                  "AROON", "NATR", "WILLR", 
                                  "CCI", "AROONOSC", "MFI", 
                                  "DX", "MINUS_DI", "PLUS_DI", 
                                  "MINUS_DM", "PLUS_DM", "ATR"]

for func in interval_timeperiod_indicators
    fname = Symbol(func)
    @eval begin
        function ($fname)(symbol::String, interval::String, time_period::Int64, datatype::String="json"; kwargs...)
            @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min", "daily", "weekly", "monthly"])
            @argcheck time_period > 0
    
            requiredParams = "&symbol=$symbol&interval=$interval&time_period=$time_period&"
            optionalParams = _parse_params(kwargs)

            uri = _form_uri_head(uppercase($func)) * requiredParams * optionalParams * "&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
            data = _get_request(uri)
            return _parse_response(data, datatype)
        end
        export $fname
    end
end

interval_timeperiod_seriestype_indicators = ["EMA", "SMA", "WMA", 
                                             "DEMA", "TEMA", "TRIMA", 
                                             "KAMA", "RSI", "T3", 
                                             "STOCHRSI", "MOM", "CMO", 
                                             "ROC", "ROCR", "TRIX", 
                                             "BBANDS", "MIDPOINT", "MIDPRICE"]

for func in interval_timeperiod_seriestype_indicators
    fname = Symbol(func)
    @eval begin 
        function ($fname)(symbol::String, interval::String, time_period::Int64, series_type::String, datatype::String="json"; kwargs...)
            @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min", "daily", "weekly", "monthly"])
            @argcheck in(series_type, ["open", "high", "low", "close"])
            @argcheck time_period > 0

            requiredParams = "&symbol=$symbol&interval=$interval&time_period=$time_period&series_type=$series_type&"
            optionalParams = _parse_params(kwargs)
            uri = _form_uri_head(uppercase($func)) * requiredParams * optionalParams * "&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
            data = _get_request(uri)
            return _parse_response(data, datatype)
        end
    export $fname
    end
end