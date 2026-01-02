module TestFundamentalValues
using AlphaVantage
using Test
import Main.TestUtils: skip_if_premium

TEST_SLEEP_TIME =  parse(Float64, get(ENV, "TEST_SLEEP_TIME", "2"))
MAX_TESTS = parse(Int64, get(ENV, "MAX_TESTS", "1"))

@testset "Fundamental Values" begin

vals = rand([AlphaVantage.INCOME_STATEMENT_KEYS;
             AlphaVantage.CASH_FLOW_KEYS;
             AlphaVantage.BALANCE_SHEET_KEYS;
             AlphaVantage.EARNINGS_KEYS_Q;
             AlphaVantage.EARNINGS_KEYS_A], MAX_TESTS)

for val in vals
    @testset "$val" begin
        @testset "Annual" begin
            fnameA = Symbol(val * "_" * "annuals")
            @eval begin
                skip_if_premium(() -> begin
                    aRes = $(fnameA)("AAPL", datatype="json")
                    @test length(aRes) == 2
                end, skip_msg="$(string($fnameA)) requires premium access")
            end
        end
        sleep(TEST_SLEEP_TIME + 2*rand())
        @testset "Quarterly" begin
            fnameQ = Symbol(val * "_" * "quarterlys")
            @eval begin
                skip_if_premium(() -> begin
                    qRes = $(fnameQ)("AAPL", datatype="json")
                    @test length(qRes) == 2
                end, skip_msg="$(string($fnameQ)) requires premium access")
            end
        end
    end
    sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
end

end

end # module
