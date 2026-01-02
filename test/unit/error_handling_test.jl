module UnitErrorHandlingTest
using AlphaVantage
using HTTP
using Test

@testset "Error Handling - Unit Tests" begin
    # Test JSON error response detection with inline fixtures
    premium_error = """{"Information": "This is a premium endpoint"}"""
    api_limit_error = """{"Note": "API limit exceeded"}"""
    valid_json = """{"Meta Data": {"Symbol": "MSFT"}}"""
    
    @testset "JSON Error Response Detection" begin
        @test AlphaVantage._is_json_error_response(premium_error) == true
        @test AlphaVantage._is_json_error_response(api_limit_error) == true
        @test AlphaVantage._is_json_error_response(valid_json) == false
        @test AlphaVantage._is_json_error_response("not json") == false
    end
    
    @testset "JSON Response Detection" begin
        @test AlphaVantage._is_json_response(valid_json) == true
        @test AlphaVantage._is_json_response("""{"test": "value"}""") == true
        @test AlphaVantage._is_json_response("timestamp,value\n2024-01-15,100") == false
        @test AlphaVantage._is_json_response("") == false
        @test AlphaVantage._is_json_response("   ") == false
    end
    
    @testset "Premium Endpoint Error Detection" begin
        resp = HTTP.Messages.Response(
            200,
            [Pair("Content-Type", "application/json")];
            body = premium_error
        )
        
        @test_throws PremiumEndpointError AlphaVantage._check_api_errors(resp)
        
        try
            AlphaVantage._check_api_errors(resp)
        catch e
            @test isa(e, PremiumEndpointError)
            @test occursin("premium", lowercase(e.message))
        end
    end
    
    @testset "API Limit Error Detection" begin
        resp = HTTP.Messages.Response(
            200,
            [Pair("Content-Type", "application/json")];
            body = api_limit_error
        )
        
        @test_throws Exception AlphaVantage._check_api_errors(resp)
    end
end

end # module

