for func in (:wti, :brent, :natural_gas, :copper, :aluminum, :wheat, :corn, :cotton, :coffee, :all_commodities)
    x = "$(func)"
    fname = Symbol(x)
    @eval begin
        function ($fname)(interval::String; client = GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default")
            @argcheck in(interval, ["daily", "weekly", "monthly"])
            @argcheck in(datatype, ["json", "csv", nothing])
            params = Dict(
                "function"=>uppercase($x),
                "interval"=>interval,
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
