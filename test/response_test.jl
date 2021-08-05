module AlphaVantageResponseTest
using AlphaVantage
using Test

@testset "Response" begin
    data = Matrix{Any}(rand(2,2))
    names = Vector{AbstractString}(["a", "b"])
    response = AlphaVantageResponse()
    x = tuple(Matrix{Any}(rand(2,2)), Matrix{AbstractString}(["col1" "col2"]))
    AlphaVantageResponse(x)
end

end
