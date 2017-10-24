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
        @test size(data) === (101, 9)
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

@testset "Weekly data" begin
    @testset "Data format: CSV" begin
        data = weekly(apikey=ENV["ALPHA_VANTAGE_API_KEY"])
        @test typeof(data) === Array{Any, 2}
        @test size(data) === (930, 6)
    end
    @testset "Data format: JSON" begin
        data = weekly(datatype="json", apikey=ENV["ALPHA_VANTAGE_API_KEY"])
        @test typeof(data) === Dict{String,Any}
        @test length(data) === 2
        @test haskey(data, "Weekly Time Series")
        @test haskey(data, "Meta Data")
        @test length(data["Weekly Time Series"]) === 929
    end
end

@testset "Weekly adjusted data" begin
    @testset "Data format: CSV" begin
        data = weekly_adjusted(apikey=ENV["ALPHA_VANTAGE_API_KEY"])
        @test typeof(data) === Array{Any, 2}
        @test size(data) === (930, 8)
    end
    @testset "Data format: JSON" begin
        data = weekly_adjusted(datatype="json", apikey=ENV["ALPHA_VANTAGE_API_KEY"])
        @test typeof(data) === Dict{String,Any}
        @test length(data) === 2
        @test haskey(data, "Weekly Adjusted Time Series")
        @test haskey(data, "Meta Data")
        @test length(data["Weekly Adjusted Time Series"]) === 929
    end
end

@testset "Monthly data" begin
    @testset "Data format: CSV" begin
        data = monthly(apikey=ENV["ALPHA_VANTAGE_API_KEY"])
        @test typeof(data) === Array{Any, 2}
        @test size(data) === (214, 6)
    end
    @testset "Data format: JSON" begin
        data = weekly(datatype="json", apikey=ENV["ALPHA_VANTAGE_API_KEY"])
        @test typeof(data) === Dict{String,Any}
        @test length(data) === 2
        @test haskey(data, "Monthly Time Series")
        @test haskey(data, "Meta Data")
        @test length(data["Monthly Time Series"]) === 213
    end
end

@testset "Monthly adjusted data" begin
    @testset "Data format: CSV" begin
        data = monthly_adjusted(apikey=ENV["ALPHA_VANTAGE_API_KEY"])
        @test typeof(data) === Array{Any, 2}
        @test size(data) === (214, 8)
    end
    @testset "Data format: JSON" begin
        data = monthly_adjusted(datatype="json", apikey=ENV["ALPHA_VANTAGE_API_KEY"])
        @test typeof(data) === Dict{String,Any}
        @test length(data) === 2
        @test haskey(data, "Monthly Adjusted Time Series")
        @test haskey(data, "Meta Data")
        @test length(data["Monthly Adjusted Time Series"]) === 213
    end
end
