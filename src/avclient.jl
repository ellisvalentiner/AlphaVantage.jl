mutable struct AlphaVantageClient
    scheme::String
    key::String
    host::String
end

const alphavantage_api = "www.alphavantage.co"

AlphaVantageClient(; scheme = "https", key = "", host = alphavantage_api) = AlphaVantageClient(scheme, key, host)

const GLOBAL = Ref(AlphaVantageClient(key = get(ENV, "ALPHA_VANTAGE_API_KEY", ""), host = get(ENV, "ALPHA_VANTAGE_HOST", "www.alphavantage.co")))

function key(client::AlphaVantageClient)
    if isempty(client.key)
        @warn "No API key found"
    end
    return client.key
end
