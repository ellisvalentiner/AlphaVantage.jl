using AlphaVantage
using Test

TEST_SLEEP_TIME =  parse(Float64, get(ENV, "TEST_SLEEP_TIME", "15"))
MAX_TESTS = parse(Int64, get(ENV, "MAX_TESTS", "1"))

@testset "AlphaVantage" begin

include("stock_time_series_test.jl")
include("foreign_exchange_curency_test.jl")
include("sector_performance_test.jl")
include("technical_indicators_test.jl")
include("digital_currency_test.jl")
include("fundamentals_test.jl")

end



