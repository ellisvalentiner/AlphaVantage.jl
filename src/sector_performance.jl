function sector_performance(datatype::String = "json")
    @argcheck in(datatype, ["json", "csv"])
    uri = "$(alphavantage_api)query?function=SECTOR&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    return _parse_response(data, datatype)
end
export sector_performance
