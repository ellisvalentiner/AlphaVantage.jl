VERSION >= v"1.0.0"

module AlphaVantage

const alphavantage_api = "https://www.alphavantage.co/"

using ArgCheck
using DelimitedFiles
using HTTP
using HttpCommon
using JSON

include("utils.jl")
include("stock_time_series.jl")
include("digital_currency.jl")
include("foreign_exchange_currency.jl")
include("stock_technical_indicators.jl")

end # module
