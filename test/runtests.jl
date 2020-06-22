using AlphaVantage
using Test

TEST_SLEEP_TIME =  parse(Float64, get(ENV, "TEST_SLEEP_TIME", 1))

@testset "Stock Time Series" begin
    for f in (:time_series_intraday, :time_series_daily)
        @eval begin
            testname = string($f)
            @testset "$testname" begin
                data = $f("MSFT")
                @test typeof(data) === Dict{String,Any}
                @test length(data) === 2
            end
        end
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end
end

@testset "Digital Currencies" begin
    for f in (:digital_currency_daily, :digital_currency_weekly, :digital_currency_monthly)
        @eval begin
            testname = string($f)
            @testset "$testname" begin
                data = $f("BTC")
                @test typeof(data) === Dict{String,Any}
                @test length(data) === 2
            end
        end
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

    @testset "crypto rating" begin
        data = crypto_rating("BTC")
        @test typeof(data) === Dict{String, Any}
        @test length(data) === 1
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

end

@testset "Foreign Exchange Currency" begin
    data = currency_exchange_rate("BTC", "USD")
    @test typeof(data) === Dict{String,Any}
    @test length(data) === 1
    sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
end
