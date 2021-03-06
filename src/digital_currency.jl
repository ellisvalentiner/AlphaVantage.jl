for func in (:daily, :weekly, :monthly)
    x = "digital_currency_$(func)"
    fname = Symbol(x)
    @eval begin
        function ($fname)(symbol::String, market::String="USD"; client = GLOBAL[], outputsize::String="compact", datatype::String="json", parser = "default")
            @argcheck in(outputsize, ["compact", "full"])
            @argcheck in(datatype, ["json", "csv"])
            uri = _form_uri_head(client, uppercase($x)) * "&symbol=$symbol&market=$market" * _form_uri_tail(client, outputsize, datatype)
            data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
            p = _parser(parser, datatype)
            return p(data)
        end
        export $fname
    end
end

function digital_currency_intraday(symbol::String, market::String="USD", interval::String="1min"; client = GLOBAL[], outputsize::String="compact", datatype::String="json", parser = "default")
    @argcheck in(outputsize, ["compact", "full"])
    @argcheck in(datatype, ["json", "csv"])
    @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min"])
    uri = _form_uri_head(client, "CRYPTO_INTRADAY") * "&symbol=$(symbol)&market=$market&interval=$(interval)" * _form_uri_tail(client, outputsize, datatype)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end

function crypto_rating(symbol::String; client = GLOBAL[], parser = "default")
    uri = _form_uri_head(client, "CRYPTO_RATING") * "&symbol=$symbol" * _form_uri_tail(client, nothing, nothing)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)

    p = _parser(parser, "json")
    return p(data)
end
