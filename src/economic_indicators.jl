
function real_gdp(interval::String = "annual"; client=GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(interval, ["quarterly", "annual"])
    @argcheck in(datatype, ["json", "csv", nothing])
    params = Dict(
        "function" => "REAL_GDP",
        "interval" => interval,
        "datatype" => isnothing(datatype) ? "csv" : datatype,
        "apikey" => key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end


function treasury_yield(interval::String = "monthly", maturity::String = "10year"; client=GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(interval, ["daily", "weekly", "monthly", nothing])
    @argcheck in(maturity, ["3month", "5year", "10year", "30year", nothing])
    @argcheck in(datatype, ["json", "csv", nothing])
    params = Dict(
        "function" => "TREASURY_YIELD",
        "interval" => interval,
        "maturity" => maturity,
        "datatype" => isnothing(datatype) ? "csv" : datatype,
        "apikey" => key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end

function federal_fund_rate(interval::String = "monthly"; client=GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(interval, ["daily", "weekly", "monthly", nothing])
    @argcheck in(datatype, ["json", "csv", nothing])
    params = Dict(
        "function" => "FEDERAL_FUNDS_RATE",
        "interval" => interval,
        "datatype" => isnothing(datatype) ? "csv" : datatype,
        "apikey" => key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end

function cpi(interval::String = "monthly"; client=GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(interval, ["monthly", "semiannual", nothing])
    @argcheck in(datatype, ["json", "csv", nothing])

    params = Dict(
        "function" => "CPI",
        "datatype" => isnothing(datatype) ? "csv" : datatype,
        "apikey" => key(client)
    )
    uri = _build_uri(client.scheme, client.host, "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end


for func in (:real_gdp_per_capita, :inflation, 
             :inflation_expectation, :consumer_sentiment,
             :retail_sales, :durables, 
             :unemployment, :nonfarm_payroll)

    @eval begin
        function $(func)(; client = GLOBAL[], datatype::Union{String, Nothing}=nothing, parser = "default")
            @argcheck in(datatype, ["json", "csv", nothing])
            params = Dict(
                "function"=>uppercase($(String(func))),
                "datatype"=>isnothing(datatype) ? "csv" : datatype,
                "apikey"=>key(client)
            )
            uri = _build_uri(client.scheme, client.host, "query", params)
            data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
            p = _parser(parser, datatype)
            return p(data)
        end
        export $func
    end

end




