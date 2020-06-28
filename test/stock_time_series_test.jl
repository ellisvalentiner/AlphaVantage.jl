
stock_time_series_functions = (:time_series_intraday, :time_series_daily, :time_series_daily_adjusted, :time_series_weekly, :time_series_weekly_adjusted, :time_series_monthly, :time_series_monthly_adjusted)

@testset "Stock Time Series" begin
    for f in stock_time_series_functions[1:MAX_TESTS]
        @eval begin
            testname = string($f)
            @testset "$testname" begin
                @testset "JSON" begin
                    data = $f("MSFT")
                    @test typeof(data) === Dict{String,Any}
                    @test length(data) === 2
                end

                @testset "CSV" begin
                    data = $f("MSFT", datatype="csv")
                    @test typeof(data) === Tuple{Array{Any, 2}, Array{AbstractString, 2}}
                    @test length(data) === 2
                end

            end
        end
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end
end