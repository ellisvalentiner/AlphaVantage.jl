for func in (:daily, :weekly, :monthly)
    x = "digital_currency_$(func)"
    fname = Symbol(x)
    @eval begin
        function ($fname)(symbol::String, market::String="USD"; client = GLOBAL[], outputsize::String="compact", datatype::String="json")
            @argcheck in(outputsize, ["compact", "full"])
            @argcheck in(datatype, ["json", "csv"])
            uri = _form_uri_head(client, uppercase($x)) * "&symbol=$symbol&market=$market" * _form_uri_tail(client, outputsize, datatype)
            data = _get_request(uri)
            return _parse_response(data, datatype)
        end
        export $fname
    end
end

function crypto_rating(symbol::String; client = GLOBAL[])
    uri = _form_uri_head(client, "CRYPTO_RATING") * "&symbol=$symbol" * _form_uri_tail(client, nothing, nothing)
    data = _get_request(uri)
    return _parse_response(data, "json")
end
export crypto_rating
