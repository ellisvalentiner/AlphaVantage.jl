# AlphaVantage

[![CI](https://github.com/ellisvalentiner/AlphaVantage.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/ellisvalentiner/AlphaVantage.jl/actions/workflows/CI.yml)
[![codecov.io](http://codecov.io/github/ellisvalentiner/AlphaVantage.jl/coverage.svg?branch=master)](http://codecov.io/github/ellisvalentiner/AlphaVantage.jl?branch=master)
[![Coverage Status](https://coveralls.io/repos/github/ellisvalentiner/AlphaVantage.jl/badge.svg?branch=master)](https://coveralls.io/github/ellisvalentiner/AlphaVantage.jl?branch=master)

A Julia wrapper for the Alpha Vantage API.

> [!IMPORTANT]
> I'm looking for contributors and maintainers to help keep the package up-to-date.

## Requirements

This package requires Julia 1.6 or later.

## Overview

This package is a Julia wrapper for the Alpha Vantage API. Alpha Vantage provides free realtime and historical data for equities, physical currencies, digital currencies (i.e. cryptocurrencies), and more than 50 technical indicators (e.g. SMA, EMA, WMA, etc.).

The Alpha Vantage API requires a [free API key](https://www.alphavantage.co/support/#api-key).

## Installation

```julia
using Pkg
Pkg.add("AlphaVantage")
```

Or via the Julia Pkg REPL:

```julia
] add AlphaVantage
```

Once you have obtained your API key, pass it to the client as follows:

```julia
using AlphaVantage
client = AlphaVantage.GLOBAL[]
client.key = "YOURKEY"
```

or set it as an environment variable

```bash
export ALPHA_VANTAGE_API_KEY=YOURKEY
```

and check that it is set using:

```julia
using AlphaVantage
AlphaVantage.GLOBAL[]
```

If you encounter a clear bug, please file a minimal reproducible example on GitHub.

## Premium Endpoints

Some Alpha Vantage API endpoints require premium API access. When calling a premium endpoint without premium access, the library will throw a `PremiumEndpointError` exception with a descriptive message.

The test suite handles premium endpoints gracefully by automatically skipping tests that require premium access when the API key doesn't have the necessary permissions. This allows the test suite to run successfully with a free API key.

If you have a premium API key and want to test premium endpoints, you can set the `TEST_PREMIUM=true` environment variable before running tests. However, the test suite will still gracefully skip premium endpoints if they're not accessible.

For a list of premium endpoints, please refer to the [Alpha Vantage documentation](https://www.alphavantage.co/documentation/).

## Testing

The test suite is split into two modes for optimal performance:

### Unit Tests (Default - Fast)

Unit tests use HTTP mocking and run in under 1 minute. They test response parsing, error handling, and data structures without making real API calls.

```bash
# Run unit tests (default)
julia --project test/runtests.jl

# Or explicitly
UNIT_TESTS=true julia --project test/runtests.jl
```

### Integration Tests (Real API)

Integration tests make real API calls to validate actual API responses. These take longer (5-10 minutes) and require an API key.

```bash
# Run integration tests
INTEGRATION_TESTS=true julia --project test/runtests.jl

# Run both unit and integration tests
UNIT_TESTS=true INTEGRATION_TESTS=true julia --project test/runtests.jl
```

### Test Configuration

- `TEST_SLEEP_TIME`: Sleep time between API calls in seconds (default: 2 seconds for integration tests)
- `MAX_TESTS`: Limit number of tests to run (default: 1)
- `TEST_PREMIUM`: Set to `true` to test premium endpoints if your API key has access
- `INTEGRATION_TESTS`: Set to `true` to run integration tests
- `UNIT_TESTS`: Set to `true` to run unit tests (default: true)

**Note**: Unit tests don't require an API key and run much faster. Use them during development for quick feedback.

## Features

* Intraday prices for stocks, currencies and cryptocurrencies.
* Daily, weekly and monthly prices for stocks, currencies, cryptocurrencies, and commodities.
* Technical indicators for stock prices.
* Crypto currency health index from Flipside Crypto.
* Fundamental data for stocks.
* Economic Indicators

## Usage

```julia
using AlphaVantage
using DataFrames, StatsPlots, Dates
gr(size=(800,470))
# Get daily S&P 500 data
spy = time_series_daily("SPY");
# Convert to a DataFrame
data = DataFrame(spy);
# Convert timestamp column to Date type
data[!, :timestamp] = Dates.Date.(data[!, :timestamp]);
data[!, :open] = Float64.(data[!, :open])
# Plot the timeseries
plot(data[!, :timestamp], data[!, :open], label=["Open"])
savefig("sp500.png")
```

![SPY Time Series](docs/src/static/spy.png)
