module UnitAPIFunctionsTest
using AlphaVantage
using Test

@testset "API Functions - Unit Tests" begin
    # Note: Full API function tests with mocks would require MockHTTP
    # These are basic structure tests that don't require network calls
    
    @testset "Client Creation" begin
        client = AlphaVantageClient(key="test_key")
        @test client.key == "test_key"
        @test client.scheme == "https"
        @test client.host == "www.alphavantage.co"
    end
    
    @testset "URI Building" begin
        client = AlphaVantageClient(key="test_key")
        params = Dict(
            "function" => "TIME_SERIES_DAILY",
            "symbol" => "MSFT",
            "apikey" => "test_key"
        )
        uri = AlphaVantage._build_uri(client.scheme, client.host, "query", params)
        
        @test startswith(uri, "https://www.alphavantage.co/query?")
        @test occursin("function=TIME_SERIES_DAILY", uri)
        @test occursin("symbol=MSFT", uri)
        @test occursin("apikey=test_key", uri)
    end
end

end # module

