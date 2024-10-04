function wti(interval::String="monthly"; client = GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(interval, ["daily", "weekly", "monthly"])
    @argcheck in(datatype, ["json", "csv", nothing])

    params = Dict(
        "function"=>"WTI",
        "interval"=>interval,
        "datatype"=>isnothing(datatype) ? "csv" : datatype,
        "apikey"=>key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end

function brent(interval::String="monthly"; client = GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(interval, ["daily", "weekly", "monthly"])
    @argcheck in(datatype, ["json", "csv", nothing])

    params = Dict(
        "function"=>"BRENT",
        "interval"=>interval,
        "datatype"=>isnothing(datatype) ? "csv" : datatype,
        "apikey"=>key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end

function natural_gas(interval::String="monthly"; client = GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(interval, ["daily", "weekly", "monthly"])
    @argcheck in(datatype, ["json", "csv", nothing])

    params = Dict(
        "function"=>"NATURAL_GAS",
        "interval"=>interval,
        "datatype"=>isnothing(datatype) ? "csv" : datatype,
        "apikey"=>key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end

function copper(interval::String="monthly"; client = GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(interval, ["daily", "weekly", "monthly"])
    @argcheck in(datatype, ["json", "csv", nothing])

    params = Dict(
        "function"=>"COPPER",
        "interval"=>interval,
        "datatype"=>isnothing(datatype) ? "csv" : datatype,
        "apikey"=>key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end

function aluminum(interval::String="monthly"; client = GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(interval, ["daily", "weekly", "monthly"])
    @argcheck in(datatype, ["json", "csv", nothing])

    params = Dict(
        "function"=>"ALUMINUM",
        "interval"=>interval,
        "datatype"=>isnothing(datatype) ? "csv" : datatype,
        "apikey"=>key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end

function wheat(interval::String="monthly"; client = GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(interval, ["daily", "weekly", "monthly"])
    @argcheck in(datatype, ["json", "csv", nothing])

    params = Dict(
        "function"=>"WHEAT",
        "interval"=>interval,
        "datatype"=>isnothing(datatype) ? "csv" : datatype,
        "apikey"=>key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end

function corn(interval::String="monthly"; client = GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(interval, ["daily", "weekly", "monthly"])
    @argcheck in(datatype, ["json", "csv", nothing])

    params = Dict(
        "function"=>"CORN",
        "interval"=>interval,
        "datatype"=>isnothing(datatype) ? "csv" : datatype,
        "apikey"=>key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end

function cotton(interval::String="monthly"; client = GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(interval, ["daily", "weekly", "monthly"])
    @argcheck in(datatype, ["json", "csv", nothing])

    params = Dict(
        "function"=>"COTTON",
        "interval"=>interval,
        "datatype"=>isnothing(datatype) ? "csv" : datatype,
        "apikey"=>key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end

function coffee(interval::String="monthly"; client = GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(interval, ["daily", "weekly", "monthly"])
    @argcheck in(datatype, ["json", "csv", nothing])

    params = Dict(
        "function"=>"COFFEE",
        "interval"=>interval,
        "datatype"=>isnothing(datatype) ? "csv" : datatype,
        "apikey"=>key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end

function all_commodities(interval::String="monthly"; client = GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(interval, ["daily", "weekly", "monthly"])
    @argcheck in(datatype, ["json", "csv", nothing])

    params = Dict(
        "function"=>"'ALL_COMMODITIES",
        "interval"=>interval,
        "datatype"=>isnothing(datatype) ? "csv" : datatype,
        "apikey"=>key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end
