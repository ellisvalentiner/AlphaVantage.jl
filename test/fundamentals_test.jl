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
end
