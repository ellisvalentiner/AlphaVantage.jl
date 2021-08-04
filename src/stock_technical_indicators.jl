interval_indicators = ["VWAP", "AD", "OBV",
                       "TRANGE", "STOCH", "STOCHF", "BOP",
                       "ULTOSC", "SAR", "ADOSC"]

for func in interval_indicators
    fname = Symbol(func)
    @eval begin
        function ($fname)(symbol::String, interval::String; client = GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default", kwargs...)
            @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min", "daily", "weekly", "monthly"])
            params = Dict(
                "function"=>uppercase($func),
                "symbol"=>symbol,
                "interval"=>interval,
                "datatype"=>isnothing(datatype) ? "csv" : datatype,
                kwargs...,
                "apikey"=>key(client)
            )
            uri = _build_uri(client.scheme, client.host, "query", params)
            data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
            p = _parser(parser, datatype)
            return p(data)
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
        function ($fname)(symbol::String, interval::String, series_type::String; client = GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default", kwargs...)
            @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min", "daily", "weekly", "monthly"])
            @argcheck in(series_type, ["open", "high", "low", "close"])
            params = Dict(
                "function"=>uppercase($func),
                "symbol"=>symbol,
                "interval"=>interval,
                "series_type"=>series_type,
                "datatype"=>isnothing(datatype) ? "csv" : datatype,
                kwargs...,
                "apikey"=>key(client)
            )
            uri = _build_uri(client.scheme, client.host, "query", params)
            data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
            p = _parser(parser, datatype)
            return p(data)
        end
    export $fname
    end
end

interval_timeperiod_indicators = ["ADX", "ADXR",
                                  "AROON", "NATR", "WILLR",
                                  "CCI", "AROONOSC", "MFI",
                                  "DX", "MINUS_DI", "PLUS_DI",
                                  "MINUS_DM", "PLUS_DM", "ATR"]

for func in interval_timeperiod_indicators
    fname = Symbol(func)
    @eval begin
        function ($fname)(symbol::String, interval::String, time_period::Int64; client = GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default", kwargs...)
            @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min", "daily", "weekly", "monthly"])
            @argcheck time_period > 0
            params = Dict(
                "function"=>uppercase($func),
                "symbol"=>symbol,
                "interval"=>interval,
                "time_period"=>time_period,
                "datatype"=>isnothing(datatype) ? "csv" : datatype,
                kwargs...,
                "apikey"=>key(client)
            )
            uri = _build_uri(client.scheme, client.host, "query", params)
            data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
            p = _parser(parser, datatype)
            return p(data)
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
        function ($fname)(symbol::String, interval::String, time_period::Int64, series_type::String; client = GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default", kwargs...)
            @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min", "daily", "weekly", "monthly"])
            @argcheck in(series_type, ["open", "high", "low", "close"])
            @argcheck time_period > 0

            params = Dict(
                "function"=>uppercase($func),
                "symbol"=>symbol,
                "interval"=>interval,
                "time_period"=>time_period,
                "series_type"=>series_type,
                "datatype"=>isnothing(datatype) ? "csv" : datatype,
                kwargs...,
                "apikey"=>key(client)
            )
            uri = _build_uri(client.scheme, client.host, "query", params)
            data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
            p = _parser(parser, datatype)
            return p(data)
        end
    export $fname
    end
end
