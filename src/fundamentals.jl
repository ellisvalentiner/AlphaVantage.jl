
# Company Overview (https://www.alphavantage.co/documentation/#company-overview)
# ex: https://www.alphavantage.co/query?function=OVERVIEW&symbol=IBM&apikey=demo

function company_overview(symbol::String; client = GLOBAL[], outputsize::String="compact", datatype::String="json")
    @argcheck in(datatype, ["json", "csv"])
    uri = _form_uri_head(client, "OVERVIEW") * "&symbol=$symbol" * _form_uri_tail(client, outputsize, datatype)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    return _parse_response(data, datatype)
end

# Income Statement (https://www.alphavantage.co/documentation/#income-statement)
# ex: https://www.alphavantage.co/query?function=INCOME_STATEMENT&symbol=IBM&apikey=demo

function income_statement(symbol::String; client = GLOBAL[], outputsize::String="compact", datatype::String="json")
    @argcheck in(datatype, ["json", "csv"])
    uri = _form_uri_head(client, "INCOME_STATEMENT") * "&symbol=$symbol" * _form_uri_tail(client, outputsize, datatype)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    return _parse_response(data, datatype)
end

# Balance Sheet (https://www.alphavantage.co/documentation/#balance-sheet)
# ex: https://www.alphavantage.co/query?function=BALANCE_SHEET&symbol=IBM&apikey=demo

function balance_sheet(symbol::String; client = GLOBAL[], outputsize::String="compact", datatype::String="json")
    @argcheck in(datatype, ["json", "csv"])
    uri = _form_uri_head(client, "BALANCE_SHEET") * "&symbol=$symbol" * _form_uri_tail(client, outputsize, datatype)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    return _parse_response(data, datatype)
end

# Cash Flow (https://www.alphavantage.co/documentation/#cash-flow)
# ex: https://www.alphavantage.co/query?function=CASH_FLOW&symbol=IBM&apikey=demo

function cash_flow(symbol::String; client = GLOBAL[], outputsize::String="compact", datatype::String="json")
    @argcheck in(datatype, ["json", "csv"])
    uri = _form_uri_head(client, "CASH_FLOW") * "&symbol=$symbol" * _form_uri_tail(client, outputsize, datatype)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    return _parse_response(data, datatype)
end

# Listing Status (https://www.alphavantage.co/documentation/#listing-status)
# ex: https://www.alphavantage.co/query?function=LISTING_STATUS&apikey=demo

function listing_status(; client = GLOBAL[], date = nothing, state = nothing)
    query = ""
    if !(state === nothing)
        @argcheck in(state, ["active", "delisted"])
        query *= "&state=$state"
    end
    !(date === nothing) && (query *= "&date=$date")

    uri = _form_uri_head(client, "LISTING_STATUS") * query * _form_uri_tail(client, nothing, nothing)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    return _parse_response(data, "csv")
end

# Earnings (https://www.alphavantage.co/documentation/#earnings)
# ex: https://www.alphavantage.co/query?function=EARNINGS&symbol=IBM&apikey=demo

function earnings(symbol::String; client = GLOBAL[], outputsize::String="compact", datatype::String="json")
    @argcheck in(datatype, ["json", "csv"])
    uri = _form_uri_head(client, "EARNINGS") * "&symbol=$symbol" * _form_uri_tail(client, outputsize, datatype)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    return _parse_response(data, datatype)
end

for (timeframe, f, value, dateKey) in FUNDAMENTAL_VALUES  

    timeframeF = replace(timeframe, "Report"=>"")
    timeframeF = replace(timeframeF, "Earnings"=>"")
    fname = Symbol(value * "_" * timeframeF)
    fS = Symbol(f)
    @eval begin
        function $fname(symbol::String)
            data = $fS(symbol)
            dts = get.(data[$timeframe], $dateKey, "")
            vals = get.(data[$timeframe], $value, "")
            Dict(:Date => dts, Symbol($value)=>vals)
        end
        export $fname
    end
 end
