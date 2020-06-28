function currency_exchange_rate(from_currency::String, to_currency::String)
    uri = _form_uri_head("CURRENCY_EXCHANGE_RATE") * "&from_currency=$from_currency&to_currency=$to_currency&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
    data = _get_request(uri)
    return _parse_response(data, "json")
end
export currency_exchange_rate

function fx_intraday(from_currency::String, to_currency::String, interval::String="1min", outputsize::String="compact", datatype::String="json")
    @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min"])
    @argcheck in(outputsize, ["compact", "full"])
    @argcheck in(datatype, ["json", "csv"])

    uri = _form_uri_head("FX_INTRADAY") * "&from_symbol=$from_currency&to_symbol=$to_currency&interval=$interval" * _form_uri_tail(outputsize, datatype)  
    data = _get_request(uri)
    return _parse_response(data, "json")
end
export fx_intraday

for func in (:daily, :weekly, :monthly)
    x = "fx_$(func)"
    fname = Symbol(x)
    @eval begin
        function ($fname)(from_currency::String, to_currency::String; datatype::String="json")
            @argcheck in(datatype, ["json", "csv"])
            uri = _form_uri_head(uppercase($x)) * "&from_symbol=$from_currency&to_symbol=$to_currency&datatype=$datatype&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
            data = _get_request(uri)
            return _parse_response(data, datatype)
        end
        export $fname
    end
end