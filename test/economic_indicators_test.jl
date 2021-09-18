module TestEconmicIndicators
using AlphaVantage
using Test

TEST_SLEEP_TIME =  parse(Float64, get(ENV, "TEST_SLEEP_TIME", "15"))
MAX_TESTS = parse(Int64, get(ENV, "MAX_TESTS", "1"))

@testset "Economic Indicators" begin
    @testset "Real GDP" begin
        res = real_gdp()
        @test length(res.names) == 2
    end

    @testset "Treasury Yield" begin
        res = treasury_yield("monthly", "3month")
        @test length(res.names) == 2
    end

    @testset "Federal Fund Rate" begin
        res = federal_fund_rate("weekly")
        @test length(res.names) == 2
    end

    @testset "CPI" begin 
        res = cpi("semiannual")
        @test length(res.names) == 2
    end

    @testset "Inflation" begin
        res = inflation()
        @test length(res.names) == 2
    end 

end


end