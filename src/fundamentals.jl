function _fundamental(func::String, symbol::String; client = GLOBAL[], outputsize::String="compact", datatype::Union{String, Nothing}=nothing, parser = "default")
    @argcheck in(datatype, ["json", "csv", nothing])
    params = Dict("function"=>func, "symbol"=>symbol, "outputsize"=>outputsize, "datatype"=>datatype, "apikey"=>key(client))
    uri = _build_uri("https", "www.alphavantage.co", "query", params)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end

company_overview(symbol::String; kwargs...) = _fundamental("OVERVIEW", symbol::String; kwargs...)
income_statement(symbol::String; kwargs...) = _fundamental("INCOME_STATEMENT", symbol::String; kwargs...)
balance_sheet(symbol::String; kwargs...) = _fundamental("BALANCE_SHEET", symbol::String; kwargs...)
cash_flow(symbol::String; kwargs...) = _fundamental("CASH_FLOW", symbol::String; kwargs...)
earnings(symbol::String; kwargs...) = _fundamental("EARNINGS", symbol::String; kwargs...)

# Listing Status (https://www.alphavantage.co/documentation/#listing-status)
# ex: https://www.alphavantage.co/query?function=LISTING_STATUS&apikey=demo
function listing_status(; client = GLOBAL[], date = nothing, state = nothing, parser = "default")
    query = ""
    if !(state === nothing)
        @argcheck in(state, ["active", "delisted"])
        query *= "&state=$state"
    end
    !(date === nothing) && (query *= "&date=$date")

    uri = _form_uri_head(client, "LISTING_STATUS") * query * _form_uri_tail(client, nothing, nothing)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, "csv")
    return p(data)
end

for (timeframe, f, value, dateKey) in FUNDAMENTAL_VALUES

    timeframeF = replace(timeframe, "Report"=>"")
    timeframeF = replace(timeframeF, "Earnings"=>"")
    fname = Symbol(value * "_" * timeframeF)
    fS = Symbol(f)
    @eval begin
        function $fname(symbol::String; kwargs...)
            data = $fS(symbol; kwargs...)
            dts = get.(data[$timeframe], $dateKey, "")
            vals = get.(data[$timeframe], $value, "")
            Dict(:Date => dts, Symbol($value)=>vals)
        end
        export $fname
    end
 end

 function earnings_calendar(horizon::Int64; client=GLOBAL[], parser = "default")
    uri = _form_uri_head(client, "EARNINGS_CALENDAR") * "&horizon=$(horizon)month" * _form_uri_tail(client)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=4, max_delay=1000))(uri)
    p = _parser(parser, "csv")
    return p(data)
 end

 function ipo_calendar(; client = GLOBAL[], parser = "default")
    uri = _form_uri_head(client, "IPO_CALENDAR") * _form_uri_tail(client)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=4, max_delay=1000))(uri)
    p = _parser(parser, "csv")
    return p(data)
 end
