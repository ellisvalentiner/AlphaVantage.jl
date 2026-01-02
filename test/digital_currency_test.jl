module TestDigitalCurrency
using AlphaVantage
using Test
import Main.TestUtils: skip_if_premium

TEST_SLEEP_TIME =  parse(Float64, get(ENV, "TEST_SLEEP_TIME", "2"))
MAX_TESTS = parse(Int64, get(ENV, "MAX_TESTS", "1"))
PREMIUM = get(ENV, "TEST_PREMIUM", false)

@testset "Digital Currencies" begin
    digital_currency_functions = (:digital_currency_intraday, :digital_currency_daily, :digital_currency_weekly, :digital_currency_monthly)
    for f in digital_currency_functions
        @eval begin
            testname = string($f)
            @testset "$testname" begin
                @testset "AlphaVantageResponse" begin
                    skip_if_premium(() -> begin
                        data = $f("BTC")
                        @test isa(data, AlphaVantageResponse)
                    end, skip_msg="$(string($f)) requires premium access")
                end
                sleep(TEST_SLEEP_TIME + 2*rand())
                @testset "JSON" begin
                    skip_if_premium(() -> begin
                        data = $f("BTC", datatype = "json")
                        @test typeof(data) === Dict{String,Any}
                        @test length(data) === 2
                    end, skip_msg="$(string($f)) requires premium access")
                end
                sleep(TEST_SLEEP_TIME + 2*rand())
                @testset "CSV" begin
                    skip_if_premium(() -> begin
                        data = $f("BTC", datatype = "csv")
                        @test typeof(data) === Tuple{Array{Any, 2}, Array{AbstractString, 2}}
                        @test length(data) === 2
                    end, skip_msg="$(string($f)) requires premium access")
                end
            end
        end
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end


end

end # module
