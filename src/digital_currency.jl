
function intraday(symbol::String="BTC"; market::String="USD", apikey::String="demo")
    _validate_args(market=market)
    uri = "$(alphavantage_api)query?function=TIME_SERIES_INTRADAY&symbol=$(symbol)&interval=$(interval)&outputsize=$(outputsize)&datatype=$(datatype)&apikey=$(apikey)"
    data = _get(uri)
    return _parse_data(data, datatype)
end
