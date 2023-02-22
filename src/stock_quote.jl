function stock_quote(symbol::String; client = GLOBAL[], parser = "default")
    params = Dict(
        "function"=>"GLOBAL_QUOTE",
        "symbol"=>symbol,
        "apikey"=>key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, "json")
    return p(data)
end

