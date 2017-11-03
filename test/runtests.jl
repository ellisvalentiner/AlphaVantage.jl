using AlphaVantage
using Base.Test

@testset "Stock Time Series" begin
    for f in (:time_series_intraday, :time_series_daily, :time_series_daily_adjusted, :time_series_weekly, :time_series_weekly_adjusted, :time_series_monthly, :time_series_monthly_adjusted)
        @eval begin
            testname = string($f)
            @testset "$testname" begin
                data = $f("MSFT")
                @test typeof(data) === Dict{String,Any}
                @test length(data) === 2
            end
        end
    end
end

@testset "Digital Currencies" begin
    for f in (:digital_currency_intraday, :digital_currency_daily, :digital_currency_weekly, :digital_currency_monthly)
        @eval begin
            testname = string($f)
            @testset "$testname" begin
                data = $f("BTC")
                @test typeof(data) === Dict{String,Any}
                @test length(data) === 2
            end
        end
    end
end

@testset "Foreign Exchange Currency" begin
    data = currency_exchange_rate("BTC", "USD")
    @test typeof(data) === Dict{String,Any}
    @test length(data) === 1
end
