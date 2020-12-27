function time_series_intraday_extended(symbol::String, interval::String="60min", slice::String="year1month1"; datatype::String="json")
    @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min"])
    @argcheck all(contains.(slice, ["year", "month"]))
    @argcheck length(findall(r"[\d]+", slice)) == 2
    @argcheck tryparse(Int, slice[findall(r"[\d]+", slice)[1]]) > 0
    @argcheck tryparse(Int, slice[findall(r"[\d]+", slice)[2]]) > 0
    @argcheck tryparse(Int, slice[findall(r"[\d]+", slice)[2]]) < 13
    @argcheck in(datatype, ["json", "csv"])
    uri = "$(alphavantage_api)query?function=TIME_SERIES_INTRADAY_EXTENDED&symbol=$symbol&interval=$interval&slice=$slice&datatype=$datatype&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
    data = _get_request(uri)
    return _parse_response(data, datatype)
end
export time_series_intraday_extended

function time_series_intraday(symbol::String, interval::String="1min"; outputsize::String="compact", datatype::String="json")
    @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min"])
    @argcheck in(outputsize, ["compact", "full"])
    @argcheck in(datatype, ["json", "csv"])
    uri = "$(alphavantage_api)query?function=TIME_SERIES_INTRADAY&symbol=$symbol&interval=$interval&outputsize=$outputsize&datatype=$datatype&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
    data = _get_request(uri)
    return _parse_response(data, datatype)
end
export time_series_intraday

for func in (:daily, :daily_adjusted, :weekly, :weekly_adjusted, :monthly, :monthly_adjusted)
    x = "time_series_$(func)"
    fname = Symbol(x)
    @eval begin
        function ($fname)(symbol::String; outputsize::String="compact", datatype::String="json")
            @argcheck in(outputsize, ["compact", "full"])
            @argcheck in(datatype, ["json", "csv"])
            uri = "$(alphavantage_api)query?function="* uppercase($x) * "&symbol=$symbol&outputsize=$outputsize&datatype=$datatype&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
            data = _get_request(uri)
            return _parse_response(data, datatype)
        end
        export $fname
    end
end
