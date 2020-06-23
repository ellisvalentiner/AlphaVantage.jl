function sector_performance(datatype::String = "json")
    @argcheck in(datatype, ["json", "csv"])
    uri = "$(alphavantage_api)query?function=SECTOR&apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
    data = _get_request(uri)
    return _parse_response(data, datatype)
end
export sector_performance
