VERSION >= v"1.0.0"

module AlphaVantage

const alphavantage_api = "https://www.alphavantage.co/"

using ArgCheck
using DelimitedFiles
using HTTP
using HttpCommon
using JSON

export set_global_key

struct Client
    key::String
    entry::String
end

Client(; key = "", entry = alphavantage_api) = Client(key, entry)

const GLOBAL = Ref(Client(key = haskey(ENV, "ALPHA_VANTAGE_API_KEY") ? ENV["ALPHA_VANTAGE_API_KEY"] : ""))

function set_global_key(key)
    GLOBAL[] = Client(key, GLOBAL[].entry)
end

function key(client::Client)
    if isempty(client.key)
        @warn "No API key found"
    end

    return client.key
end

entry(client::Client) = client.entry

include("utils.jl")
include("stock_time_series.jl")
include("digital_currency.jl")
include("foreign_exchange_currency.jl")
include("stock_technical_indicators.jl")
include("sector_performance.jl")
include("fundamentals.jl")

end # module
