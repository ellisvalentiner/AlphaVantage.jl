module TestFundamentals
using AlphaVantage
using Test

TEST_SLEEP_TIME =  parse(Float64, get(ENV, "TEST_SLEEP_TIME", "15"))
MAX_TESTS = parse(Int64, get(ENV, "MAX_TESTS", "1"))

@testset "Fundamentals" begin
    symbol = "IBM"

    @testset "Overview" begin
        data = company_overview(symbol)
        @test typeof(data) === Dict{String, Any}
        @test length(data) === 59
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

    @testset "Income Statement" begin
        data = income_statement(symbol)
        @test typeof(data) === Dict{String, Any}
        @test length(data) === 3
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

    @testset "Balance Sheet" begin
        data = balance_sheet(symbol)
        @test typeof(data) === Dict{String, Any}
        @test length(data) === 3
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

    @testset "Cash Flow" begin
        data = cash_flow(symbol)
        @test typeof(data) === Dict{String, Any}
        @test length(data) === 3
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

    @testset "Earnings" begin
        data = earnings(symbol)
        @test typeof(data) === Dict{String, Any}
        @test length(data) === 3
        sleep(TEST_SLEEP_TIME + 2*rand()) #as to not overload the API
    end

    @testset "Listing Status" begin
        @testset "Default" begin
            data = listing_status()
            @test length(data) == 2
        end

        @testset "Delisted and Date" begin
            data = listing_status(state = "delisted", date = "2020-12-17")
            @test length(data) == 2
        end        
    end

end

end # module
