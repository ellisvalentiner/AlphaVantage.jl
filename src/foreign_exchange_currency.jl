function currency_exchange_rate(from_currency::String, to_currency::String)
    uri = "$(alphavantage_api)query?function=CURRENCY_EXCHANGE_RATE&from_currency=$from_currency&to_currency=$to_currency&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
    data = _get_request(uri)
    return _parse_response(data, "json")
end
export currency_exchange_rate
