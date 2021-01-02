for func in (:daily, :weekly, :monthly)
    x = "digital_currency_$(func)"
    fname = Symbol(x)
    @eval begin
        function ($fname)(symbol::String, market::String="USD"; outputsize::String="compact", datatype::String="json")
            @argcheck in(outputsize, ["compact", "full"])
            @argcheck in(datatype, ["json", "csv"])
            uri = "$(alphavantage_api)query?function="* uppercase($x) * "&symbol=$symbol&market=$market&outputsize=$outputsize&datatype=$datatype&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
            data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
            return _parse_response(data, datatype)
        end
        export $fname
    end
end

function crypto_rating(symbol::String)
    uri = "$(alphavantage_api)query?function=CRYPTO_RATING&symbol=$symbol&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    return _parse_response(data, "json")
end
export crypto_rating