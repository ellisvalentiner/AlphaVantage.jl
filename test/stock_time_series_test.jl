module TestStockTimeSeries
using AlphaVantage
using Test
using JSON3
import Main.TestUtils: skip_if_premium

TEST_SLEEP_TIME =  parse(Float64, get(ENV, "TEST_SLEEP_TIME", "2"))
MAX_TESTS = parse(Int64, get(ENV, "MAX_TESTS", "1"))
PREMIUM = get(ENV, "TEST_PREMIUM", false)

stock_time_series_functions = [:time_series_daily_adjusted, :time_series_weekly, :time_series_weekly_adjusted, :time_series_monthly, :time_series_monthly_adjusted]
stock_time_series_functions_test = vcat(:time_series_intraday, stock_time_series_functions[1:MAX_TESTS])
if PREMIUM
    stock_time_series_functions_test = vcat(:time_series_daily, stock_time_series_functions_test)
end

@testset "Stock Time Series" begin
    for f in stock_time_series_functions_test
        @eval begin
            testname = string($f)
            @testset "$testname" begin
                @testset "AlphaVantageResponse" begin
                    skip_if_premium(() -> begin
                        data = $f("MSFT")
                        @test isa(data, AlphaVantageResponse)
                    end, skip_msg="$(string($f)) requires premium access")
                end
                sleep(TEST_SLEEP_TIME + 2*rand())
                @testset "JSON" begin
                    skip_if_premium(() -> begin
                        data = $f("MSFT", datatype="json")
                        @test typeof(data) === Dict{String,Any}
                        @test length(data) === 2
                    end, skip_msg="$(string($f)) requires premium access")
                end
                sleep(TEST_SLEEP_TIME + 2*rand())
                @testset "CSV" begin
                    skip_if_premium(() -> begin
                        data = $f("MSFT", datatype="csv")
                        @test typeof(data) === Tuple{Array{Any, 2}, Array{AbstractString, 2}}
                        @test length(data) === 2
                    end, skip_msg="$(string($f)) requires premium access")
                end
                sleep(TEST_SLEEP_TIME + 2*rand())
                @testset "JSON3" begin
                    skip_if_premium(() -> begin
                        data = $f("MSFT", datatype="json", parser = x -> JSON3.read(x.body))
                        @test typeof(data) === JSON3.Object{Vector{UInt8}, Vector{UInt64}}
                        @test length(data) === 2
                    end, skip_msg="$(string($f)) requires premium access")
                end
            end
        end
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

    f = :time_series_intraday_extended
    @eval begin
        testname = string($f)
        @testset "$testname" begin
            skip_if_premium(() -> begin
                data = $f("MSFT")
                @test typeof(data) === Tuple{Array{Any, 2}, Array{AbstractString, 2}}
                @test length(data) === 2
            end, skip_msg="$(string($f)) requires premium access")
        end
    end
end

end # module
