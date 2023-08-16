function time_series_intraday(symbol::String, interval::String="1min"; client = GLOBAL[], outputsize::String="compact", datatype::Union{String, Nothing}=nothing, parser = "default", adjusted::Bool=true, extended_hours::Bool=true, month::Union{String, Nothing}=nothing)
    @argcheck in(interval, ["1min", "5min", "15min", "30min", "60min"])
    @argcheck in(outputsize, ["compact", "full"])
    @argcheck in(datatype, ["json", "csv", nothing])
    if month != nothing
        @argcheck occursin(r"^\d{4}-(0[1-9]|1[0-2])$", month) # month must be in MMMM-YY format 
        @argcheck Date(month) >= Date("2000-01")
    end
    params = Dict(
        "function"=>"TIME_SERIES_INTRADAY",
        "symbol"=>symbol,
        "interval"=>interval,
        "outputsize"=>outputsize,
        "datatype"=>datatype,
        "adjusted"=>string(adjusted),
        "extended_hours"=>string(extended_hours),
        "month"=>month,
        "apikey"=>key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end

for func in (:daily, :daily_adjusted, :weekly, :weekly_adjusted, :monthly, :monthly_adjusted)
    x = "time_series_$(func)"
    fname = Symbol(x)
    @eval begin
        function ($fname)(symbol::String; client = GLOBAL[], outputsize::String="compact", datatype::Union{String, Nothing}=nothing, parser = "default")
            @argcheck in(outputsize, ["compact", "full"])
            @argcheck in(datatype, ["json", "csv", nothing])
            params = Dict(
                "function"=>uppercase($x),
                "symbol"=>symbol,
                "outputsize"=>outputsize,
                "datatype"=>isnothing(datatype) ? "csv" : datatype,
                "apikey"=>key(client)
            )
            uri = _build_uri(client.scheme, client.host, "query", params)
            data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
            p = _parser(parser, datatype)
            return p(data)
        end

        export $fname
    end
end
