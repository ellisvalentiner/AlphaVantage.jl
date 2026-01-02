module UnitResponseTest
using AlphaVantage
using Test
using Tables

@testset "AlphaVantageResponse - Unit Tests" begin
    @testset "Construction from Matrix" begin
        names = Matrix{AbstractString}(["a" "b"])
        data = Matrix{Any}(rand(2, 2))
        response = AlphaVantageResponse(data, names)
        @test isa(response, AlphaVantageResponse)
        @test length(response.names) == 2
        @test length(response.data) == 2
    end
    
    @testset "Construction from Tuple" begin
        names = Matrix{AbstractString}(["timestamp" "value"])
        data = Matrix{Any}([["2024-01-15" "2024-01-14"]; [100.0 99.0]])
        response = AlphaVantageResponse(tuple(data, names))
        @test isa(response, AlphaVantageResponse)
    end
    
    @testset "Construction from Dict" begin
        d = Dict("a" => [1, 2, 3], "b" => [4, 5, 6])
        response = AlphaVantageResponse(d)
        # Dict constructor returns a Tables.table, not AlphaVantageResponse
        @test Tables.istable(response)
    end
    
    @testset "Tables Interface" begin
        names = Matrix{AbstractString}(["col1" "col2"])
        data = Matrix{Any}([["a" "b"]; [1 2]])
        response = AlphaVantageResponse(data, names)
        
        @test Tables.istable(response)
        @test Tables.columnaccess(response)
        @test !Tables.rowaccess(response)
        
        cols = Tables.columns(response)
        @test cols === response
        
        col1 = Tables.getcolumn(response, :col1)
        @test length(col1) == 2  # 2 rows in the data
        
        col2 = Tables.getcolumn(response, 2)
        @test length(col2) == 2  # 2 rows in the data
        
        colnames = Tables.columnnames(response)
        @test colnames == [:col1, :col2]
    end
end

end # module

