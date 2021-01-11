function time_series_intraday(symbol::String, interval::String="1min"; outputsize::String="compact", datatype::String="json")
    @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min"])
    @argcheck in(outputsize, ["compact", "full"])
    @argcheck in(datatype, ["json", "csv"])
    uri = _form_uri_head(client, "TIME_SERIES_INTRADAY") * "&symbol=$symbol&interval=$interval" * _form_uri_tail(client, outputsize, datatype)
    data = _get_request(uri)
    return _parse_response(data, datatype)
end

for func in (:daily, :daily_adjusted, :weekly, :weekly_adjusted, :monthly, :monthly_adjusted)
    x = "time_series_$(func)"
    fname = Symbol(x)
    @eval begin
        function ($fname)(symbol::String; client = GLOBAL[], outputsize::String="compact", datatype::String="json")
            @argcheck in(outputsize, ["compact", "full"])
            @argcheck in(datatype, ["json", "csv"])
            uri = _form_uri_head(client, uppercase($x)) * "&symbol=$symbol" * _form_uri_tail(client, outputsize, datatype)
            data = _get_request(uri)
            return _parse_response(data, datatype)
        end

        export $fname
    end
end
