module UnitUtilsTest
using AlphaVantage
using HTTP
using Test

@testset "Utils - Unit Tests" begin
    @testset "URI Building" begin
        params = Dict(
            "function" => "TIME_SERIES_DAILY",
            "symbol" => "MSFT",
            "apikey" => "demo"
        )
        uri = AlphaVantage._build_uri("https", "www.alphavantage.co", "query", params)
        
        @test startswith(uri, "https://www.alphavantage.co/query?")
        @test occursin("function=TIME_SERIES_DAILY", uri)
        @test occursin("symbol=MSFT", uri)
        @test occursin("apikey=demo", uri)
    end
    
    @testset "Response Parsing - JSON" begin
        json_body = """{"Meta Data": {"Symbol": "MSFT"}, "Time Series (Daily)": {"2024-01-15": {"1. open": "380.0"}}}"""
        resp = HTTP.Messages.Response(
            200,
            [Pair("Content-Type", "application/json")];
            body = json_body
        )
        
        parsed = AlphaVantage._parse_response(resp, "json")
        @test isa(parsed, Dict)
        @test haskey(parsed, "Meta Data")
        @test haskey(parsed, "Time Series (Daily)")
    end
    
    @testset "Response Parsing - CSV" begin
        csv_body = "timestamp,open,high,low,close,volume\n2024-01-15,380.0,385.0,378.0,382.5,25000000"
        resp = HTTP.Messages.Response(
            200,
            [Pair("Content-Type", "text/csv")];
            body = csv_body
        )
        
        parsed = AlphaVantage._parse_response(resp, "csv")
        @test isa(parsed, Tuple)
        @test length(parsed) == 2
    end
    
    @testset "Response Parsing - Auto-detect JSON" begin
        json_body = """{"Global Quote": {"01. symbol": "MSFT", "05. price": "382.50"}}"""
        resp = HTTP.Messages.Response(
            200,
            [Pair("Content-Type", "application/json")];
            body = json_body
        )
        
        parsed = AlphaVantage._parse_response(resp, nothing)
        @test isa(parsed, Dict)
        @test haskey(parsed, "Global Quote")
    end
end

end # module
