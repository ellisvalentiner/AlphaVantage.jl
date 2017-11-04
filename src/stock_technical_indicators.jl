function technical_indicator(func::String; symbol::String="SMA", interval::String="1min", time_period::Integer=60, series_type::String="close")
    uri = "$(alphavantage_api)query?function=$func&from_currency=$from_currency&to_currency=$to_currency&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
    data = _get_request(uri)
    return _parse_response(data, datatype)
end
export technical_indicator
