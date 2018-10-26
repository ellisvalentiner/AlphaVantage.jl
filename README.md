# AlphaVantage

[![Build Status](https://travis-ci.org/ellisvalentiner/AlphaVantage.jl.svg?branch=master)](https://travis-ci.org/ellisvalentiner/AlphaVantage.jl)

[![Coverage Status](https://coveralls.io/repos/ellisvalentiner/AlphaVantage.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/ellisvalentiner/AlphaVantage.jl?branch=master)

[![codecov.io](http://codecov.io/github/ellisvalentiner/AlphaVantage.jl/coverage.svg?branch=master)](http://codecov.io/github/ellisvalentiner/AlphaVantage.jl?branch=master)

[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://ellisvalentiner.github.io/AlphaVantage.jl/stable)
[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://ellisvalentiner.github.io/AlphaVantage.jl/latest)

A Julia wrapper for the Alpha Vantage API.

## Overview

This package is a Julia wrapper for the Alpha Vantage API. Alpha Vantage provides free realtime and historical data for equities, digital currencies (i.e. cryptocurrencies), and more than 50 technical indicators (e.g. SMA, EMA, WMA, etc.).

The Alpha Vantage API requires a [free API key](https://www.alphavantage.co/support/#api-key).

## Installation

```julia
# AlphaVantage.jl is not currently registered as an official package
# Please install the development version from GitHub:
pkg> add git://github.com:ellisvalentiner/AlphaVantage.jl#master
```

If you encounter a clear bug, please file a minimal reproducible example on GitHub.

## Usage

```julia
using AlphaVantage
using DataFrames
using Dates
using Plots
gr(size=(800,470))
# Get daily S&P 500 data
gspc = time_series_daily("^GSPC", datatype="csv");
# Convert to a DataFrame
data = DataFrame(gspc[1]);
# Add column names
names!(data, Symbol.(gspc[2])[1,:]);
# Convert timestamp column to Date type
data[:timestamp] = Dates.Date.(data[:timestamp]);
# Plot the timeseries
plot(
  data[:timestamp],
  data[:close],
  title="S&P 500",
  lw=3,
  labels="",
  color=:black,
  ylims=(minimum(data[:close])*0.95, maximum(data[:close])*1.025)
)
savefig("sp500.png")
```

![](docs/src/static/sp500.png)
