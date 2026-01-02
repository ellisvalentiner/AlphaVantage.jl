module TestTechnicalIndicators
using AlphaVantage
using Test
import Main.TestUtils: skip_if_premium

TEST_SLEEP_TIME =  parse(Float64, get(ENV, "TEST_SLEEP_TIME", "2"))
MAX_TESTS = parse(Int64, get(ENV, "MAX_TESTS", "1"))
PREMIUM = get(ENV, "TEST_PREMIUM", false)

@testset "Technical Indicators" begin

    @testset "Interval, Time Period, Series Type" begin
        for ti in Symbol.(AlphaVantage.interval_timeperiod_seriestype_indicators[1:MAX_TESTS])
            @eval begin
                tiname = string($ti)
                @testset "technical_indicator: $tiname" begin
                    @testset "JSON" begin
                        skip_if_premium(() -> begin
                            data = $ti("MSFT", "weekly", 10, "open", datatype="json")
                            @test typeof(data) === Dict{String, Any}
                            @test length(data) === 2
                        end, skip_msg="$(string($ti)) requires premium access")
                    end
                    sleep(TEST_SLEEP_TIME + 2*rand())
                    @testset "CSV" begin
                        skip_if_premium(() -> begin
                            data = $ti("MSFT", "weekly", 10, "open", datatype="csv")
                            @test typeof(data) === Tuple{Array{Any, 2}, Array{AbstractString, 2}}
                            @test length(data) === 2
                        end, skip_msg="$(string($ti)) requires premium access")
                    end
                end
            end
            sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
        end
    end

    @testset "Interval, Time Period" begin
        for ti in Symbol.(AlphaVantage.interval_timeperiod_indicators[1:MAX_TESTS])
            if ti in (:ADX, :CCI) && !PREMIUM
                continue
            end
            @eval begin
                tiname = string($ti)
                @testset "technical_indicator: $tiname" begin
                    @testset "JSON" begin
                        skip_if_premium(() -> begin
                            data = $ti("MSFT", "weekly", 10, datatype="json")
                            @test typeof(data) === Dict{String, Any}
                            @test length(data) === 2
                        end, skip_msg="$(string($ti)) requires premium access")
                    end
                    sleep(TEST_SLEEP_TIME + 2*rand())
                    @testset "CSV" begin
                        skip_if_premium(() -> begin
                            data = $ti("MSFT", "weekly", 10, datatype="csv")
                            @test typeof(data) === Tuple{Array{Any, 2}, Array{AbstractString, 2}}
                            @test length(data) === 2
                        end, skip_msg="$(string($ti)) requires premium access")
                    end
                end
            end
            sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
        end
    end

    @testset "Interval, Series Type" begin
        for ti in Symbol.(AlphaVantage.interval_seriestype_indicators[1:MAX_TESTS])
            if ti == :RSI && !PREMIUM
                continue
            end
            @eval begin
                tiname = string($ti)
                @testset "technical_indicator: $tiname" begin
                    @testset "JSON" begin
                        data = $ti("MSFT", "weekly", "open", datatype="json")
                        @test typeof(data) === Dict{String, Any}
                        @test length(data) === 2
                    end
                    sleep(TEST_SLEEP_TIME + 2*rand())
                    @testset "CSV" begin
                        data = $ti("MSFT", "weekly", "open", datatype="csv")
                        @test typeof(data) === Tuple{Array{Any, 2}, Array{AbstractString, 2}}
                        @test length(data) === 2
                    end

                end
            end
            sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
        end
    end

    @testset "Interval" begin
        for ti in Symbol.(AlphaVantage.interval_indicators[1:MAX_TESTS])
            if ti == :STOCH && !PREMIUM
                continue
            end
            @eval begin
                tiname = string($ti)
                @testset "technical_indicator: $tiname" begin
                    @testset "JSON" begin
                        data = $ti("MSFT", "15min", datatype="json")
                        @test typeof(data) === Dict{String, Any}
                        @test length(data) === 2
                    end
                    sleep(TEST_SLEEP_TIME + 2*rand())
                    @testset "CSV" begin
                        data = $ti("MSFT", "15min", datatype="csv")
                        @test typeof(data) === Tuple{Array{Any, 2}, Array{AbstractString, 2}}
                        @test length(data) === 2
                    end
                end
            end
            sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
        end
    end

    @testset "Optional Arguments" begin
        skip_if_premium(() -> begin
            data = MACD("MSFT", "5min", "high", fastperiod = 13, slowperiod = 25, datatype="json")
            @test typeof(data) === Dict{String, Any}
            @test length(data) === 2
            @test data["Meta Data"]["5.2: Slow Period"] == 25
            @test data["Meta Data"]["5.1: Fast Period"] == 13
        end, skip_msg="MACD requires premium access")
    end

end

end # module
