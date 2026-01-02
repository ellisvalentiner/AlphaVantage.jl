module TestEconmicIndicators
using AlphaVantage
using Test
import Main.TestUtils: skip_if_premium

TEST_SLEEP_TIME =  parse(Float64, get(ENV, "TEST_SLEEP_TIME", "2"))
MAX_TESTS = parse(Int64, get(ENV, "MAX_TESTS", "1"))

@testset "Economic Indicators" begin
    @testset "Real GDP" begin
        skip_if_premium(() -> begin
            res = real_gdp()
            @test length(res.names) == 2
        end, skip_msg="real_gdp requires premium access")
    end

    @testset "Treasury Yield" begin
        skip_if_premium(() -> begin
            res = treasury_yield("monthly", "3month")
            @test length(res.names) == 2
        end, skip_msg="treasury_yield requires premium access")
    end

    @testset "Federal Fund Rate" begin
        skip_if_premium(() -> begin
            res = federal_fund_rate("weekly")
            @test length(res.names) == 2
        end, skip_msg="federal_fund_rate requires premium access")
    end

    @testset "CPI" begin 
        skip_if_premium(() -> begin
            res = cpi("semiannual")
            @test length(res.names) == 2
        end, skip_msg="cpi requires premium access")
    end

    @testset "Inflation" begin
        skip_if_premium(() -> begin
            res = inflation()
            @test length(res.names) == 2
        end, skip_msg="inflation requires premium access")
    end 

end


end