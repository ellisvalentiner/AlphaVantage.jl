VERSION >= v"1.0.0"

module AlphaVantage

const alphavantage_api = "https://www.alphavantage.co/"

using ArgCheck
using DelimitedFiles
using HTTP
using HttpCommon
using JSON

function __init__()
    if !haskey(ENV, "ALPHA_VANTAGE_API_KEY")
        @warn "No API key found"
    end
end


include("utils.jl")
include("stock_time_series.jl")
include("digital_currency.jl")
include("foreign_exchange_currency.jl")
include("stock_technical_indicators.jl")
include("sector_performance.jl")
include("fundamental_values.jl")
include("fundamentals.jl")

end # module
