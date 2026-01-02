using AlphaVantage
using Test
using JSON3

# Configuration
TEST_SLEEP_TIME = parse(Float64, get(ENV, "TEST_SLEEP_TIME", "2"))
MAX_TESTS = parse(Int64, get(ENV, "MAX_TESTS", "1"))
RUN_INTEGRATION_TESTS = get(ENV, "INTEGRATION_TESTS", "false") == "true"
RUN_UNIT_TESTS = get(ENV, "UNIT_TESTS", "true") == "true"

# If no test type specified, default to unit tests only
if !RUN_INTEGRATION_TESTS && !RUN_UNIT_TESTS
    RUN_UNIT_TESTS = true
end

@testset "AlphaVantage" begin
    
    # Always include test utilities
    include("test_utils.jl")
    
    # Unit tests (fast, with mocks)
    if RUN_UNIT_TESTS
        @testset "Unit Tests" begin
            # Include mocking infrastructure and fixtures
            include("mock_http.jl")
            include("fixtures.jl")
            
            # Make MockHTTP and Fixtures available to unit tests
            using .MockHTTP
            using .Fixtures
            
            # Unit test files
            include("unit/utils_test.jl")
            include("unit/response_test.jl")
            include("unit/error_handling_test.jl")
            include("unit/api_functions_test.jl")
            
            # Also include existing unit-testable files
            include("client_test.jl")
            include("response_test.jl")
            include("utils_test.jl")
        end
    end
    
    # Integration tests (slower, real API calls)
    if RUN_INTEGRATION_TESTS
        if !haskey(ENV, "ALPHA_VANTAGE_API_KEY")
            @warn "Skipping integration tests: ALPHA_VANTAGE_API_KEY not set"
        else
            @testset "Integration Tests" begin
            # Integration test files (real API calls)
            include("stock_time_series_test.jl")
            include("stock_quote_test.jl")
            include("foreign_exchange_curency_test.jl")
            include("sector_performance_test.jl")
            include("digital_currency_test.jl")
            include("technical_indicators_test.jl")
            include("fundamentals_test.jl")
            include("fundamental_values_test.jl")
            include("economic_indicators_test.jl")
            end
        end
    end

end
