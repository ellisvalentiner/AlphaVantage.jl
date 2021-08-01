module TestClient
using AlphaVantage
using Test

client = AlphaVantage.GLOBAL[]
@test !isempty(client.key)
