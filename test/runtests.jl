using AlphaVantage
using Test
using JSON3

TEST_SLEEP_TIME =  parse(Float64, get(ENV, "TEST_SLEEP_TIME", "20"))
MAX_TESTS = parse(Int64, get(ENV, "MAX_TESTS", "1"))

@test haskey(ENV, "ALPHA_VANTAGE_API_KEY")

@testset "AlphaVantage" begin

include("client_test.jl")
include("stock_time_series_test.jl")
include("foreign_exchange_curency_test.jl")
include("sector_performance_test.jl")
include("digital_currency_test.jl")
include("technical_indicators_test.jl")
include("fundamentals_test.jl")
include("fundamental_values_test.jl")

end
