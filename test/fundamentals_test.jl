module TestFundamentals
using AlphaVantage
using Test
import Main.TestUtils: skip_if_premium

TEST_SLEEP_TIME =  parse(Float64, get(ENV, "TEST_SLEEP_TIME", "2"))
MAX_TESTS = parse(Int64, get(ENV, "MAX_TESTS", "1"))

@testset "Fundamentals" begin
    symbol = "IBM"

    @testset "Overview" begin
        skip_if_premium(() -> begin
            data = company_overview(symbol, datatype="json")
            @test typeof(data) === Dict{String, Any}
            @test length(data) === 46
        end, skip_msg="company_overview requires premium access")
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

    @testset "Income Statement" begin
        skip_if_premium(() -> begin
            data = income_statement(symbol, datatype="json")
            @test typeof(data) === Dict{String, Any}
            @test length(data) === 3
        end, skip_msg="income_statement requires premium access")
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

    @testset "Balance Sheet" begin
        skip_if_premium(() -> begin
            data = balance_sheet(symbol, datatype="json")
            @test typeof(data) === Dict{String, Any}
            @test length(data) === 3
        end, skip_msg="balance_sheet requires premium access")
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

    @testset "Cash Flow" begin
        skip_if_premium(() -> begin
            data = cash_flow(symbol, datatype="json")
            @test typeof(data) === Dict{String, Any}
            @test length(data) === 3
        end, skip_msg="cash_flow requires premium access")
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

    @testset "Earnings" begin
        skip_if_premium(() -> begin
            data = earnings(symbol, datatype="json")
            @test typeof(data) === Dict{String, Any}
            @test length(data) === 3
        end, skip_msg="earnings requires premium access")
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

    @testset "Listing Status" begin
        @testset "Default" begin
            skip_if_premium(() -> begin
                data = listing_status()
                @test length(data) == 2
            end, skip_msg="listing_status requires premium access")
            sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
        end

        @testset "Delisted and Date" begin
            skip_if_premium(() -> begin
                data = listing_status(state = "delisted", date = "2020-12-17")
                @test length(data) == 2
            end, skip_msg="listing_status requires premium access")
            sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
        end
    end

    @testset "Earnings Calendar" begin
        skip_if_premium(() -> begin
            data = earnings_calendar(3)
            @test length(data) == 2
        end, skip_msg="earnings_calendar requires premium access")
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

    @testset "IPO Calendar" begin
        skip_if_premium(() -> begin
            data = ipo_calendar()
            @test length(data) == 2
        end, skip_msg="ipo_calendar requires premium access")
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end
end

end # module
