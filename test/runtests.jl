using AlphaVantage
using Base.Test

@testset "Intraday data" begin
    @testset "CSV" begin
        data = intraday(apikey=ENV["ALPHA_VANTAGE_API_KEY"])
        @test typeof(data) === Array{Any, 2}
        @test size(data) === (101, 6)
    end
    @testset "JSON" begin
        data = intraday(datatype="json", apikey=ENV["ALPHA_VANTAGE_API_KEY"])
        @test typeof(data) === Dict{String,Any}
        @test length(data) === 2
        @test haskey(data, "Time Series (1min)")
        @test haskey(data, "Meta Data")
        @test length(data["Time Series (1min)"]) === 100
    end
end
