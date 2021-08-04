const alphavantage_api = "www.alphavantage.co"

struct AVClient
    scheme::String
    key::String
    host::String
end

AVClient(; scheme = "https", key = "", host = alphavantage_api) = AVClient(scheme, key, host)

const GLOBAL = Ref(AVClient(key = get(ENV, "ALPHA_VANTAGE_API_KEY", "")))

function global_key!(key)
    GLOBAL[] = AVClient(key, GLOBAL[].host)
end

function global_host!(host)
    GLOBAL[] = AVClient(GLOBAL[].key, host)
end

function key(client::AVClient)
    if isempty(client.key)
        @warn "No API key found"
    end

    return client.key
end

host(client::AVClient) = client.host
key(client::AVClient) = client.key
