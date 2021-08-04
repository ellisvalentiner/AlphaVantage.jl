module TestClient
using AlphaVantage
using Test

client = AlphaVantage.GLOBAL[]
@testset "Client" begin
    @test !isempty(client.scheme)
    @test !isempty(client.key)
    @test !isempty(client.host)
    old_key = client.key;
    client.key = "demo"
    @test client.key === "demo"
    client.key = ""
    @test_logs (:warn, "No API key found") key(client)
    client.key = old_key;
end

end
