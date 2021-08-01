module TestFundamentalValues
using AlphaVantage
using Test

TEST_SLEEP_TIME =  parse(Float64, get(ENV, "TEST_SLEEP_TIME", "15"))
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
                aRes = $(fnameA)("AAPL", datatype="csv")
                @test length(aRes) == 2
            end
        end
        sleep(TEST_SLEEP_TIME + 2*rand())
        @testset "Quarterly" begin
            fnameQ = Symbol(val * "_" * "quarterlys")
            @eval begin
                qRes = $(fnameQ)("AAPL", datatype="csv")
                @test length(qRes) == 2
            end
        end
    end
    sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
end

end

end # module
