module TestStockQuote
using AlphaVantage
using Test
import Main.TestUtils: skip_if_premium

TEST_SLEEP_TIME =  parse(Float64, get(ENV, "TEST_SLEEP_TIME", "2"))
MAX_TESTS = parse(Int64, get(ENV, "MAX_TESTS", "1"))

@testset "Stock quote" begin
    @testset "stock_quote" begin
        skip_if_premium(() -> begin
            data = stock_quote("MSFT")
            @test typeof(data) === Dict{String,Any}
            @test length(data) === 1
            @test parse(Float64, data["Global Quote"]["08. previous close"]) > 0
        end, skip_msg="stock_quote requires premium access")
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end
end

end # module
