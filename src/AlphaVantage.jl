VERSION >= v"0.6.0"

module AlphaVantage

const alphavantage_api = "https://www.alphavantage.co/"

using Requests
using HttpCommon

include("utils.jl")
include("stock_time_series.jl")
export intraday, daily, daily_adjusted, weekly, weekly_adjusted, monthly, monthly_adjusted

end # module
