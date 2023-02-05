# AlphaVantage

[![CI](https://github.com/ellisvalentiner/AlphaVantage.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/ellisvalentiner/AlphaVantage.jl/actions/workflows/CI.yml)
[![codecov.io](http://codecov.io/github/ellisvalentiner/AlphaVantage.jl/coverage.svg?branch=master)](http://codecov.io/github/ellisvalentiner/AlphaVantage.jl?branch=master)
[![Coverage Status](https://coveralls.io/repos/github/ellisvalentiner/AlphaVantage.jl/badge.svg?branch=master)](https://coveralls.io/github/ellisvalentiner/AlphaVantage.jl?branch=master)

A Julia wrapper for the Alpha Vantage API.

## Overview

This package is a Julia wrapper for the Alpha Vantage API. Alpha Vantage provides free realtime and historical data for equities, physical currencies, digital currencies (i.e. cryptocurrencies), and more than 50 technical indicators (e.g. SMA, EMA, WMA, etc.).

The Alpha Vantage API requires a [free API key](https://www.alphavantage.co/support/#api-key).

## Installation

```julia
Pkg.add("AlphaVantage")
```
and once you have obtained your API key pass it to the client as follows:.

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

## Features

* Intraday prices for stocks, currencies and cryptocurrencies.
* Daily, weekly and monthly prices for stocks, currencies and cryptocurrencies.
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

![](docs/src/static/spy.png)
