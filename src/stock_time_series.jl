
"""
Returns intraday time series (timestamp, open, high, low, close, volume) of the equity specified, updated realtime.
"""
function intraday(symbol::String="MSFT"; interval::String="1min", outputsize::String="compact", datatype::String="csv", apikey::String="demo")
    _validate_args(interval=interval, outputsize=outputsize, datatype=datatype)
    uri = "$(alphavantage_api)query?function=TIME_SERIES_INTRADAY&symbol=$(symbol)&interval=$(interval)&outputsize=$(outputsize)&datatype=$(datatype)&apikey=$(apikey)"
    data = _get(uri)
    return _parse_data(data, datatype)
end

"""
Returns daily time series (date, daily open, daily high, daily low, daily close, daily volume) of the equity specified, covering up to 20 years of historical data.

The most recent data point is the cumulative prices and volume information of the current trading day, updated realtime.
"""
function daily(symbol::String="MSFT"; outputsize::String="compact", datatype::String="csv", apikey::String="demo")
    _validate_args(outputsize=outputsize, datatype=datatype)
    uri = "$(alphavantage_api)query?function=TIME_SERIES_DAILY&symbol=$(symbol)&outputsize=$(outputsize)&datatype=$(datatype)&apikey=$(apikey)"
    data = _get(uri)
    return _parse_data(data, datatype)
end

"""
Returns daily time series (date, daily open, daily high, daily low, daily close, daily volume, daily adjusted close, and split/dividend events) of the equity specified, covering up to 20 years of historical data.

The most recent data point is the cumulative prices and volume information of the current trading day, updated realtime.
"""
function daily_adjusted(symbol::String="MSFT"; outputsize::String="compact", datatype::String="csv", apikey::String="demo")
    _validate_args(outputsize=outputsize, datatype=datatype)
    uri = "$(alphavantage_api)query?function=TIME_SERIES_DAILY&symbol=$(symbol)&outputsize=$(outputsize)&datatype=$(datatype)&apikey=$(apikey)"
    data = _get(uri)
    return _parse_data(data, datatype)
end

"""
Returns weekly time series (last trading day of each week, weekly open, weekly high, weekly low, weekly close, weekly volume) of the equity specified, covering up to 20 years of historical data.

The latest data point is the cumulative prices and volume information for the week (or partial week) that contains the current trading day, updated realtime.
"""
function weekly(symbol::String="MSFT"; outputsize::String="compact", datatype::String="csv", apikey::String="demo")
    _validate_args(outputsize=outputsize, datatype=datatype)
    uri = "$(alphavantage_api)query?function=TIME_SERIES_DAILY&symbol=$(symbol)&outputsize=$(outputsize)&datatype=$(datatype)&apikey=$(apikey)"
    data = _get(uri)
    return _parse_data(data, datatype)
end

"""
Returns weekly adjusted time series (last trading day of each week, weekly open, weekly high, weekly low, weekly close, weekly adjusted close, weekly volume, weekly dividend) of the equity specified, covering up to 20 years of historical data.

The latest data point is the cumulative prices and volume information for the week (or partial week) that contains the current trading day, updated realtime.
"""
function weekly_adjusted(symbol::String="MSFT"; outputsize::String="compact", datatype::String="csv", apikey::String="demo")
    _validate_args(outputsize=outputsize, datatype=datatype)
    uri = "$(alphavantage_api)query?function=TIME_SERIES_DAILY&symbol=$(symbol)&outputsize=$(outputsize)&datatype=$(datatype)&apikey=$(apikey)"
    data = _get(uri)
    return _parse_data(data, datatype)
end

"""
Returns monthly time series (last trading day of each month, monthly open, monthly high, monthly low, monthly close, monthly volume) of the equity specified, covering up to 20 years of historical data.

The latest data point is the cumulative prices and volume information for the month (or partial month) that contains the current trading day, updated realtime.
"""
function monthly(symbol::String="MSFT"; outputsize::String="compact", datatype::String="csv", apikey::String="demo")
    _validate_args(outputsize=outputsize, datatype=datatype)
    uri = "$(alphavantage_api)query?function=TIME_SERIES_DAILY&symbol=$(symbol)&outputsize=$(outputsize)&datatype=$(datatype)&apikey=$(apikey)"
    data = _get(uri)
    return _parse_data(data, datatype)
end

"""
Returns monthly adjusted time series (last trading day of each month, monthly open, monthly high, monthly low, monthly close, monthly adjusted close, monthly volume, monthly dividend) of the equity specified, covering up to 20 years of historical data.

The latest data point is the cumulative prices and volume information for the month (or partial month) that contains the current trading day, updated realtime.
"""
function monthly_adjusted(symbol::String="MSFT"; outputsize::String="compact", datatype::String="csv", apikey::String="demo")
    _validate_args(outputsize=outputsize, datatype=datatype)
    uri = "$(alphavantage_api)query?function=TIME_SERIES_DAILY&symbol=$(symbol)&outputsize=$(outputsize)&datatype=$(datatype)&apikey=$(apikey)"
    data = _get(uri)
    return _parse_data(data, datatype)
end
