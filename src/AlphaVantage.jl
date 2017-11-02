VERSION >= v"0.6.0"

module AlphaVantage

const alphavantage_api = "https://www.alphavantage.co/"

using Requests
using HttpCommon

include("utils.jl")
include("stock_time_series.jl")
export time_series_intraday, time_series_daily, time_series_daily_adjusted

end # module
