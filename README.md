# AlphaVantage

[![Build Status](https://travis-ci.org/ellisvalentiner/AlphaVantage.jl.svg?branch=master)](https://travis-ci.org/ellisvalentiner/AlphaVantage.jl)

[![codecov.io](http://codecov.io/github/ellisvalentiner/AlphaVantage.jl/coverage.svg?branch=master)](http://codecov.io/github/ellisvalentiner/AlphaVantage.jl?branch=master)

[![Coverage Status](https://coveralls.io/repos/github/ellisvalentiner/AlphaVantage.jl/badge.svg?branch=master)](https://coveralls.io/github/ellisvalentiner/AlphaVantage.jl?branch=master)

A Julia wrapper for the Alpha Vantage API.

## Overview

This package is a Julia wrapper for the Alpha Vantage API. Alpha Vantage provides free realtime and historical data for equities, digital currencies (i.e. cryptocurrencies), and more than 50 technical indicators (e.g. SMA, EMA, WMA, etc.).

The Alpha Vantage API requires a [free API key](https://www.alphavantage.co/support/#api-key).

## Installation

```julia
# AlphaVantage.jl is not currently registered as an official package
# Please install the development version from GitHub:
Pkg.clone("git://GitHub.com/ellisvalentiner/AlphaVantage.jl")
```

If you encounter a clear bug, please file a minimal reproducible example on GitHub.

## Usage

```julia
using AlphaVantage
using DataFrames
using StatPlots
gr(size=(800,470))
# Get daily S&P 500 data
spy = time_series_daily("SPY", datatype="csv");
# Convert to a DataFrame
data = DataFrame(spy[1]);
# Add column names
data = rename(data, Symbol.(vcat(spy[2]...)));
# Convert timestamp column to Date type
data[!, :timestamp] = Dates.Date.(data[!, :timestamp]);
data[!, :open] = Float64.(data[!, :open])
# Plot the timeseries
plot(data[!, :timestamp], data[!, :open], label=["Open"])
savefig("sp500.png")
```

![](docs/src/static/spy.png)
