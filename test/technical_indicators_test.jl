@testset "Technical Indicators" begin

    @testset "Interval, Time Period, Series Type" begin
        for ti in Symbol.(AlphaVantage.interval_timeperiod_seriestype_indicators[1:2])
            @eval begin
                tiname = string($ti)
                @testset "technical_indicator: $tiname" begin
                    data = $ti("MSFT", "weekly", 10, "open")
                    @test typeof(data) === Dict{String, Any}
                    @test length(data) === 2
                end
            end
            sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
        end
    end

    @testset "Interval, Time Period" begin
        for ti in Symbol.(AlphaVantage.interval_timeperiod_indicators[1:2])
            @eval begin
                tiname = string($ti)
                @testset "technical_indicator: $tiname" begin
                    data = $ti("MSFT", "weekly", 10)
                    @test typeof(data) === Dict{String, Any}
                    @test length(data) === 2
                end
            end
            sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
        end
    end

    @testset "Interval, Series Type" begin
        for ti in Symbol.(AlphaVantage.interval_seriestype_indicators[1:2])
            @eval begin
                tiname = string($ti)
                @testset "technical_indicator: $tiname" begin
                    data = $ti("MSFT", "weekly", "open")
                    @test typeof(data) === Dict{String, Any}
                    @test length(data) === 2
                end
            end
            sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
        end
    end

    @testset "Interval" begin
        for ti in Symbol.(AlphaVantage.interval_indicators[1:2])
            @eval begin
                tiname = string($ti)
                @testset "technical_indicator: $tiname" begin
                    data = $ti("MSFT", "15min")
                    @test typeof(data) === Dict{String, Any}
                    @test length(data) === 2
                end
            end
            sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
        end
    end

end
