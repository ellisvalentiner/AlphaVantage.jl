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
        sleep(60)
    end
end

@testset "Digital Currencies" begin
    for f in (:digital_currency_intraday, :digital_currency_daily)
        @eval begin
            testname = string($f)
            @testset "$testname" begin
                data = $f("BTC", datatype="json")
                @test typeof(data) === Dict{String,Any}
                @test length(data) === 2
            end
        end
        sleep(60)
    end
    for f in (:digital_currency_intraday, :digital_currency_daily)
        @eval begin
            testname = string($f)
            @testset "$testname" begin
                data = $f("BTC", datatype="csv")
                @test typeof(data) === Tuple{Array{Any,2},Array{AbstractString,2}}
                @test length(data) === 2
            end
        end
        sleep(60)
    end
end

@testset "Foreign Exchange Currency" begin
    data = currency_exchange_rate("BTC", "USD")
    @test typeof(data) === Dict{String,Any}
    @test length(data) === 1
end
