"""
Test fixtures containing sample API responses for mocking.

These fixtures represent typical responses from the Alpha Vantage API
and can be used in unit tests to avoid making real API calls.
"""
module Fixtures

"""
Sample successful JSON response for TIME_SERIES_DAILY
"""
const TIME_SERIES_DAILY_JSON = """{
    "Meta Data": {
        "1. Information": "Daily Prices (open, high, low, close) and Volumes",
        "2. Symbol": "MSFT",
        "3. Last Refreshed": "2024-01-15",
        "4. Output Size": "Compact",
        "5. Time Zone": "US/Eastern"
    },
    "Time Series (Daily)": {
        "2024-01-15": {
            "1. open": "380.0000",
            "2. high": "385.0000",
            "3. low": "378.0000",
            "4. close": "382.5000",
            "5. volume": "25000000"
        },
        "2024-01-14": {
            "1. open": "375.0000",
            "2. high": "380.0000",
            "3. low": "374.0000",
            "4. close": "379.0000",
            "5. volume": "22000000"
        }
    }
}"""

"""
Sample successful CSV response for TIME_SERIES_DAILY
"""
const TIME_SERIES_DAILY_CSV = """timestamp,open,high,low,close,volume
2024-01-15,380.0000,385.0000,378.0000,382.5000,25000000
2024-01-14,375.0000,380.0000,374.0000,379.0000,22000000"""

"""
Sample successful JSON response for GLOBAL_QUOTE
"""
const GLOBAL_QUOTE_JSON = """{
    "Global Quote": {
        "01. symbol": "MSFT",
        "02. open": "380.0000",
        "03. high": "385.0000",
        "04. low": "378.0000",
        "05. price": "382.5000",
        "06. volume": "25000000",
        "07. latest trading day": "2024-01-15",
        "08. previous close": "379.0000",
        "09. change": "3.5000",
        "10. change percent": "0.9235%"
    }
}"""

"""
Sample premium endpoint error response
"""
const PREMIUM_ENDPOINT_ERROR = """{
    "Information": "Thank you for using Alpha Vantage! This is a premium endpoint. You may subscribe to any of the premium plans at https://www.alphavantage.co/premium/ to instantly unlock all premium endpoints"
}"""

"""
Sample API limit exceeded error response
"""
const API_LIMIT_ERROR = """{
    "Note": "Thank you for using Alpha Vantage! Our standard API call frequency is 5 calls per minute and 500 calls per day. Please visit https://www.alphavantage.co/premium/ if you would like to target a higher API call frequency."
}"""

"""
Sample successful JSON response for COMPANY_OVERVIEW
"""
const COMPANY_OVERVIEW_JSON = """{
    "Symbol": "IBM",
    "AssetType": "Common Stock",
    "Name": "International Business Machines Corporation",
    "Description": "International Business Machines Corporation...",
    "CIK": "0000051143",
    "Exchange": "NYSE",
    "Currency": "USD",
    "Country": "USA",
    "Sector": "Technology",
    "Industry": "Information Technology Services",
    "Address": "1 New Orchard Road, Armonk, New York, 10504, United States",
    "FullTimeEmployees": "288300",
    "FiscalYearEnd": "December",
    "LatestQuarter": "2023-12-31",
    "MarketCapitalization": "150000000000",
    "EBITDA": "12000000000",
    "PERatio": "25.5",
    "PEGRatio": "2.1",
    "BookValue": "25.30",
    "DividendPerShare": "6.64",
    "DividendYield": "0.042",
    "EPS": "10.00",
    "RevenuePerShareTTM": "65.50",
    "ProfitMargin": "0.12",
    "OperatingMarginTTM": "0.15",
    "ReturnOnAssetsTTM": "0.08",
    "ReturnOnEquityTTM": "0.35",
    "RevenueTTM": "60000000000",
    "GrossProfitTTM": "35000000000",
    "DilutedEPSTTM": "9.85",
    "QuarterlyEarningsGrowthYOY": "0.05",
    "QuarterlyRevenueGrowthYOY": "0.03",
    "AnalystTargetPrice": "185.00",
    "TrailingPE": "25.5",
    "ForwardPE": "18.2",
    "PriceToSalesRatioTTM": "2.5",
    "PriceToBookRatio": "7.4",
    "EVToRevenue": "2.8",
    "EVToEBITDA": "12.5",
    "Beta": "0.95",
    "52WeekHigh": "200.00",
    "52WeekLow": "120.00",
    "50DayMovingAverage": "175.00",
    "200DayMovingAverage": "160.00",
    "SharesOutstanding": "900000000",
    "DividendDate": "2024-03-10",
    "ExDividendDate": "2024-02-29"
}"""

"""
Sample successful JSON response for technical indicator (SMA)
"""
const SMA_JSON = """{
    "Meta Data": {
        "1: Symbol": "MSFT",
        "2: Indicator": "Simple Moving Average (SMA)",
        "3: Last Refreshed": "2024-01-15",
        "4: Interval": "daily",
        "5: Time Period": 10,
        "6: Series Type": "close",
        "7: Time Zone": "US/Eastern"
    },
    "Technical Analysis: SMA": {
        "2024-01-15": {
            "SMA": "380.5000"
        },
        "2024-01-14": {
            "SMA": "379.2000"
        }
    }
}"""

"""
Sample successful CSV response for technical indicator
"""
const SMA_CSV = """time,SMA
2024-01-15,380.5000
2024-01-14,379.2000"""

"""
Sample successful JSON response for CURRENCY_EXCHANGE_RATE
"""
const CURRENCY_EXCHANGE_RATE_JSON = """{
    "Realtime Currency Exchange Rate": {
        "1. From_Currency Code": "BTC",
        "2. From_Currency Name": "Bitcoin",
        "3. To_Currency Code": "USD",
        "4. To_Currency Name": "United States Dollar",
        "5. Exchange Rate": "45000.00000000",
        "6. Last Refreshed": "2024-01-15 12:00:00",
        "7. Time Zone": "UTC",
        "8. Bid Price": "44995.00000000",
        "9. Ask Price": "45005.00000000"
    }
}"""

"""
Sample successful JSON response for SECTOR_PERFORMANCE
"""
const SECTOR_PERFORMANCE_JSON = """{
    "Meta Data": {
        "Information": "US Sector Performance (Sector)",
        "Last Refreshed": "2024-01-15 16:00:00",
        "Time Zone": "US/Eastern"
    },
    "Rank A: Real-Time Performance": {
        "Information Technology": "2.5%",
        "Health Care": "1.8%",
        "Financials": "1.2%"
    }
}"""

"""
Get a fixture by name.

# Arguments
- `name`: Symbol or String name of the fixture

# Example
```julia
fixture(:TIME_SERIES_DAILY_JSON)
```
"""
function fixture(name::Symbol)
    return getfield(Fixtures, name)
end

function fixture(name::String)
    return fixture(Symbol(name))
end

export TIME_SERIES_DAILY_JSON, TIME_SERIES_DAILY_CSV, GLOBAL_QUOTE_JSON,
       PREMIUM_ENDPOINT_ERROR, API_LIMIT_ERROR, COMPANY_OVERVIEW_JSON,
       SMA_JSON, SMA_CSV, CURRENCY_EXCHANGE_RATE_JSON, SECTOR_PERFORMANCE_JSON,
       fixture

end # module

