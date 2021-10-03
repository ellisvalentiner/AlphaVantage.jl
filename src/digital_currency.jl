for func in (:daily, :weekly, :monthly)
    x = "digital_currency_$(func)"
    fname = Symbol(x)
    @eval begin
        function ($fname)(symbol::String, market::String="USD"; client = GLOBAL[], outputsize::String="compact", datatype::Union{String, Nothing}=nothing, parser = "default")
            @argcheck in(outputsize, ["compact", "full"])
            @argcheck in(datatype, ["json", "csv", nothing])
            params = Dict(
                "function"=>uppercase($x),
                "symbol"=>symbol,
                "market"=>market,
                "outputsize"=>outputsize,
                "datatype"=>isnothing(datatype) ? "csv" : datatype,
                "apikey"=>key(client)
            )
            uri = _build_uri(client.scheme, client.host, "query", params)
            data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
            p = _parser(parser, datatype)
            return p(data)
        end
        export $fname
    end
end

function digital_currency_intraday(symbol::String, market::String="USD", interval::String="1min"; client = GLOBAL[], outputsize::String="compact", datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(outputsize, ["compact", "full"])
    @argcheck in(datatype, ["json", "csv", nothing])
    @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min"])
    params = Dict(
        "function"=>"CRYPTO_INTRADAY",
        "symbol"=>symbol,
        "market"=>market,
        "interval"=>interval,
        "outputsize"=>outputsize,
        "datatype"=>isnothing(datatype) ? "csv" : datatype,
        "apikey"=>key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end

function crypto_rating(symbol::String; client = GLOBAL[], parser = "default")
    @warn("crypto_rating no longer provided by AlphaVantage")
    return nothing
end
