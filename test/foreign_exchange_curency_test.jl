module TestForeignExchangeCurrency
using AlphaVantage
using Test

TEST_SLEEP_TIME =  parse(Float64, get(ENV, "TEST_SLEEP_TIME", "15"))
MAX_TESTS = parse(Int64, get(ENV, "MAX_TESTS", "1"))
PREMIUM = get(ENV, "TEST_PREMIUM", false)

@testset "Foreign Exchange Currency" begin
    @testset "currency_exchange_rate" begin
        data = currency_exchange_rate("BTC", "USD")
        @test typeof(data) === Dict{String,Any}
        @test length(data) === 1
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

    if PREMIUM
        @testset "fx_intraday" begin
            data = fx_intraday("EUR", "USD", datatype="json")
            @test typeof(data) === Dict{String,Any}
            @test length(data) === 2
            sleep(TEST_SLEEP_TIME + 2*rand())
        end
    end

    @testset "fx_daily" begin
        data = fx_daily("EUR", "USD", datatype="json")
        @test typeof(data) === Dict{String,Any}
        @test length(data) === 2
        sleep(TEST_SLEEP_TIME + 2*rand())
    end

    for f in (:fx_weekly, :fx_monthly)[1:MAX_TESTS]
        @eval begin
            testname = string($f)
            @testset "$testname" begin
                data = $f("EUR", "USD", datatype="json")
                @test typeof(data) === Dict{String,Any}
                @test length(data) === 2
            end
        end
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

end

end # module
