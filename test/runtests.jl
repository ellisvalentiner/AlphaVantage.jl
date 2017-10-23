using AlphaVantage
using Base.Test

@testset "Intraday data" begin
    @testset "Data format: CSV" begin
        data = intraday(apikey=ENV["ALPHA_VANTAGE_API_KEY"])
        @test typeof(data) === Array{Any, 2}
        @test size(data) === (101, 6)
    end
    @testset "Data format: JSON" begin
        data = intraday(datatype="json", apikey=ENV["ALPHA_VANTAGE_API_KEY"])
        @test typeof(data) === Dict{String,Any}
        @test length(data) === 2
        @test haskey(data, "Time Series (1min)")
        @test haskey(data, "Meta Data")
        @test length(data["Time Series (1min)"]) === 100
    end
end

@testset "Daily data" begin
    @testset "Data format: CSV" begin
        data = daily(apikey=ENV["ALPHA_VANTAGE_API_KEY"])
        @test typeof(data) === Array{Any, 2}
        @test size(data) === (101, 6)
    end
    @testset "Data format: JSON" begin
        data = daily(datatype="json", apikey=ENV["ALPHA_VANTAGE_API_KEY"])
        @test typeof(data) === Dict{String,Any}
        @test length(data) === 2
        @test haskey(data, "Time Series (Daily)")
        @test haskey(data, "Meta Data")
        @test length(data["Time Series (Daily)"]) === 100
    end
end

@testset "Daily adjusted data" begin
    @testset "Data format: CSV" begin
        data = daily_adjusted(apikey=ENV["ALPHA_VANTAGE_API_KEY"])
        @test typeof(data) === Array{Any, 2}
        @test size(data) === (101, 6)
    end
    @testset "Data format: JSON" begin
        data = daily_adjusted(datatype="json", apikey=ENV["ALPHA_VANTAGE_API_KEY"])
        @test typeof(data) === Dict{String,Any}
        @test length(data) === 2
        @test haskey(data, "Time Series (Daily)")
        @test haskey(data, "Meta Data")
        @test length(data["Time Series (Daily)"]) === 100
    end
end
