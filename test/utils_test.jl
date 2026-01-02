module UtilsTest
using AlphaVantage
using HTTP
using Test

@testset "Utils" begin
    resp = HTTP.Messages.Response(
        200,
        [
            Pair("Content-Type", "application/json")
        ];
        body="""{"Note": "API limit exceeded"}"""
    )
    @test_throws Exception AlphaVantage._check_api_errors(resp)
end

end
