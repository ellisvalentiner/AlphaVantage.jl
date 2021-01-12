const alphavantage_api = "https://www.alphavantage.co/"

struct AVClient
    key::String
    entry::String
end

AVClient(; key = "", entry = alphavantage_api) = AVClient(key, entry)

const GLOBAL = Ref(AVClient(key = get(ENV, "ALPHA_VANTAGE_API_KEY", "")))

function global_key!(key)
    GLOBAL[] = AVClient(key, GLOBAL[].entry)
end

function global_entry!(entry)
    GLOBAL[] = AVClient(GLOBAL[].key, entry)
end

function key(client::AVClient)
    if isempty(client.key)
        @warn "No API key found"
    end

    return client.key
end

entry(client::AVClient) = client.entry
