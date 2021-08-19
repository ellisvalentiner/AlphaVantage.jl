module TestSectorPerformance
using AlphaVantage
using Test

TEST_SLEEP_TIME =  parse(Float64, get(ENV, "TEST_SLEEP_TIME", "15"))
MAX_TESTS = parse(Int64, get(ENV, "MAX_TESTS", "1"))

@testset "Sector Performance" begin
    data = sector_performance()
    @test isa(data, AlphaVantageResponse)
    sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
end

end # module
