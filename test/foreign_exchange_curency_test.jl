@testset "Foreign Exchange Currency" begin
    @testset "currency_exchange_rate" begin
        data = currency_exchange_rate("BTC", "USD")
        @test typeof(data) === Dict{String,Any}
        @test length(data) === 1
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

    @testset "fx_intraday" begin
        data = fx_intraday("EUR", "USD")
        @test typeof(data) === Dict{String,Any}
        @test length(data) === 2
        sleep(TEST_SLEEP_TIME + 2*rand())
    end

    for f in (:fx_daily, :fx_weekly, :fx_monthly)[1:MAX_TESTS]
        @eval begin
            testname = string($f)
            @testset "$testname" begin
                data = $f("EUR", "USD")
                @test typeof(data) === Dict{String,Any}
                @test length(data) === 2
            end
        end
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

end