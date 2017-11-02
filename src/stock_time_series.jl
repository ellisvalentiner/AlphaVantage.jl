#
# function time_series_intraday(symbol; interval="1min", outputsize="compact", datatype="json")
#     # _validate_args
#     data = _request("TIME_SERIES_INTRADAY", symbol=symbol, interval=interval, outputsize=outputsize)
#     _parse_response(data, datatype)
# end
#

for func in (:daily, :daily_adjusted, :weekly, :weekly_adjusted, :monthly, :monthly_adjusted)
    x = "time_series_$(func)"
    fname = Symbol(x)
    @eval ($fname)(symbol; outputsize="compact", datatype="json") = _request(uppercase($x), symbol=symbol, outputsize=outputsize)
end
