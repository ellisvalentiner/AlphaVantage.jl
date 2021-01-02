function time_series_intraday_extended(symbol::String, interval::String="60min", slice::String="year1month1")
    @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min"])
    sliceMatch = match(r"year(?<year>\d+)month(?<month>\d+)", slice)
    @argcheck !isnothing(sliceMatch)
    @argcheck parse(Int, sliceMatch["year"]) > 0
    @argcheck parse(Int, sliceMatch["year"]) < 3
    @argcheck parse(Int, sliceMatch["month"]) > 0
    @argcheck parse(Int, sliceMatch["month"]) < 13
    uri = "$(alphavantage_api)query?function=TIME_SERIES_INTRADAY_EXTENDED&symbol=$symbol&interval=$interval&slice=$slice&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    return _parse_response(data, "csv")
end
export time_series_intraday_extended

function time_series_intraday(symbol::String, interval::String="1min"; outputsize::String="compact", datatype::String="json")
    @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min"])
    @argcheck in(outputsize, ["compact", "full"])
    @argcheck in(datatype, ["json", "csv"])
    uri = "$(alphavantage_api)query?function=TIME_SERIES_INTRADAY&symbol=$symbol&interval=$interval&outputsize=$outputsize&datatype=$datatype&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
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
            data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
            return _parse_response(data, datatype)
        end
        export $fname
    end
end
