module TestSectorPerformance
using AlphaVantage
using Test
import Main.TestUtils: skip_if_premium

TEST_SLEEP_TIME =  parse(Float64, get(ENV, "TEST_SLEEP_TIME", "2"))
MAX_TESTS = parse(Int64, get(ENV, "MAX_TESTS", "1"))

@testset "Sector Performance" begin
    skip_if_premium(() -> begin
        data = sector_performance()
        @test isa(data, AlphaVantageResponse)
    end, skip_msg="sector_performance requires premium access")
    sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
end

end # module
