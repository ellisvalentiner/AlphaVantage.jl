function currency_exchange_rate(from_currency::String, to_currency::String; client = GLOBAL[], parser = "default")
    params = Dict(
        "function"=>"CURRENCY_EXCHANGE_RATE",
        "from_currency"=>from_currency,
        "to_currency"=>to_currency,
        "apikey"=>key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, "json")
    return p(data)
end

function fx_intraday(from_currency::String, to_currency::String, interval::String="1min"; client = GLOBAL[], outputsize::String="compact", datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min"])
    @argcheck in(outputsize, ["compact", "full"])
    @argcheck in(datatype, ["json", "csv", nothing])

    params = Dict(
        "function"=>"FX_INTRADAY",
        "from_symbol"=>from_currency,
        "to_symbol"=>to_currency,
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

function fx_daily(from_currency::String, to_currency::String; client = GLOBAL[], outputsize::String="compact", datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(outputsize, ["compact", "full"])
    @argcheck in(datatype, ["json", "csv", nothing])

    params = Dict(
        "function"=>"FX_DAILY",
        "from_symbol"=>from_currency,
        "to_symbol"=>to_currency,
        "outputsize"=>outputsize,
        "datatype"=>isnothing(datatype) ? "csv" : datatype,
        "apikey"=>key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end

for func in (:weekly, :monthly)
    x = "fx_$(func)"
    fname = Symbol(x)
    @eval begin
        function ($fname)(from_currency::String, to_currency::String; client = GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default")
            @argcheck in(datatype, ["json", "csv", nothing])
            params = Dict(
                "function"=>uppercase($x),
                "from_symbol"=>from_currency,
                "to_symbol"=>to_currency,
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
