var documenterSearchIndex = {"docs":
[{"location":"#AlphaVantage.jl-Documentation","page":"AlphaVantage.jl Documentation","title":"AlphaVantage.jl Documentation","text":"","category":"section"},{"location":"","page":"AlphaVantage.jl Documentation","title":"AlphaVantage.jl Documentation","text":"A Julia wrapper for the Alpha Vantage API.","category":"page"},{"location":"#Overview","page":"AlphaVantage.jl Documentation","title":"Overview","text":"","category":"section"},{"location":"","page":"AlphaVantage.jl Documentation","title":"AlphaVantage.jl Documentation","text":"This package is a Julia wrapper for the Alpha Vantage API. Alpha Vantage provides free realtime and historical data for equities, digital currencies (i.e. cryptocurrencies), and more than 50 technical indicators (e.g. SMA, EMA, WMA, etc.).","category":"page"},{"location":"","page":"AlphaVantage.jl Documentation","title":"AlphaVantage.jl Documentation","text":"The Alpha Vantage API requires a free API key.","category":"page"},{"location":"#Installation","page":"AlphaVantage.jl Documentation","title":"Installation","text":"","category":"section"},{"location":"","page":"AlphaVantage.jl Documentation","title":"AlphaVantage.jl Documentation","text":"# AlphaVantage.jl is not currently registered as an official package\n# Please install the development version from GitHub:\nPkg.clone(\"git://GitHub.com/ellisvalentiner/AlphaVantage.jl\")","category":"page"},{"location":"","page":"AlphaVantage.jl Documentation","title":"AlphaVantage.jl Documentation","text":"If you encounter a clear bug, please file a minimal reproducible example on GitHub.","category":"page"},{"location":"#Functions","page":"AlphaVantage.jl Documentation","title":"Functions","text":"","category":"section"},{"location":"#Stock-Time-Series","page":"AlphaVantage.jl Documentation","title":"Stock Time Series","text":"","category":"section"},{"location":"","page":"AlphaVantage.jl Documentation","title":"AlphaVantage.jl Documentation","text":"time_series_intraday()\ntime_series_daily()\ntime_series_daily_adjusted()\ntime_series_weekly()\ntime_series_weekly_adjusted()\ntime_series_monthly()\ntime_series_monthly_adjusted()","category":"page"},{"location":"#Digital-Currencies","page":"AlphaVantage.jl Documentation","title":"Digital Currencies","text":"","category":"section"},{"location":"","page":"AlphaVantage.jl Documentation","title":"AlphaVantage.jl Documentation","text":"digital_currencies_daily()\ndigital_currencies_weekly()\ndigital_currencies_monthly()","category":"page"},{"location":"#Usage","page":"AlphaVantage.jl Documentation","title":"Usage","text":"","category":"section"},{"location":"","page":"AlphaVantage.jl Documentation","title":"AlphaVantage.jl Documentation","text":"using AlphaVantage\nusing DataFrames\nusing Plots\ngr(size=(800,470))\n# Get daily S&P 500 data\ngspc = time_series_daily(\"^GSPC\", apikey=ENV[\"ALPHA_VANTAGE_API_KEY\"]);\n# Convert to a DataFrame\ndata = DataFrame(gspc[2:end, :]);\n# Add column names\nnames!(data, convert.(Symbol, gspc[1,:]));\n# Convert timestamp column to Date type\ndata[:timestamp] = Dates.Date.(data[:timestamp]);\n# Plot the timeseries\n@df data plot(:timestamp, [:low :high :close], label=[\"Low\" \"High\" \"Close\"], colour=[:red :green :blue], w=2)\nsavefig(\"sp500.png\")","category":"page"},{"location":"","page":"AlphaVantage.jl Documentation","title":"AlphaVantage.jl Documentation","text":"(Image: )","category":"page"}]
}
