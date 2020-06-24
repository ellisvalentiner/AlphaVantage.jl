@testset "Sector Performance" begin 
    data = sector_performance()
    @test typeof(data) === Dict{String, Any}
    @test length(data) === 11
    sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
end
