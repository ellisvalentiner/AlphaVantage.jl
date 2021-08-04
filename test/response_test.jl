module AlphaVantageResponseTest
using AlphaVantage
using Test

@testset "" begin
    x = tuple(Matrix{Any}(rand(2,2)), Matrix{AbstractString}(["col1" "col2"]))
    AlphaVantageResponse(x)
end

end
