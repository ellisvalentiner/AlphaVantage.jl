module AlphaVantageResponseTest
using AlphaVantage
using Test

@testset "Response" begin
    names = Matrix{AbstractString}(["a" "b"])

    data = Matrix{Any}(rand(2, 2))
    response = AlphaVantageResponse(data, names)
    @test isa(response, AlphaVantageResponse)

    response = AlphaVantageResponse(tuple(data, names))
    @test isa(response, AlphaVantageResponse)
end

end
