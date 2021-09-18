VERSION >= v"1.6.0"

module AlphaVantage

using Compat
using ArgCheck
using DelimitedFiles
using HTTP
using JSON

include("avclient.jl")
include("avresponse.jl")
include("utils.jl")
include("stock_time_series.jl")
include("digital_currency.jl")
include("foreign_exchange_currency.jl")
include("stock_technical_indicators.jl")
include("sector_performance.jl")
include("fundamental_values.jl")
include("fundamentals.jl")
include("economic_indicators.jl")

# avclient
export key, AlphaVantageClient, AlphaVantageResponse

# stock_time_series
export
    time_series_intraday,
    time_series_intraday_extended
# `time_series_daily` etc are exported in macro

# digital_currency
export crypto_rating, digital_currency_intraday
# `digital_currency_daily` etc are exported in macro

# foreign_exchange_currency
export
    currency_exchange_rate,
    fx_intraday,
    fx_daily
# `fx_weekly` etc are exported in macro

# stock_technical_indicators
# `VWAP` etc are exported in macro

# sector_performance
export sector_performance

# fundamentals
export
    company_overview,
    income_statement,
    balance_sheet,
    cash_flow,
    listing_status,
    earnings,
    earnings_calendar,
    ipo_calendar

# economic_indicators
# others exported in macro
export
    real_gdp,
    treasury_yield,
    federal_fund_rate,
    cpi

end # module
