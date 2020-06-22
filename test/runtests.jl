using AlphaVantage
using Test

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
        sleep(15 + 2*rand()) #as to not overload the API
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
    sleep(15 + 2*rand()) #as to not overload the API
    end

    @testset "crypto rating" begin
        data = crypto_rating("BTC")
        @test typeof(data) === Dict{String, Any}
        @test length(data) === 1
    end

end

@testset "Foreign Exchange Currency" begin
    data = currency_exchange_rate("BTC", "USD")
    @test typeof(data) === Dict{String,Any}
    @test length(data) === 1
end
