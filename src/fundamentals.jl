
# Company Overview (https://www.alphavantage.co/documentation/#company-overview)
# ex: https://www.alphavantage.co/query?function=OVERVIEW&symbol=IBM&apikey=demo

function company_overview(symbol::String; client = GLOBAL[], outputsize::String="compact", datatype::String="json")
    @argcheck in(datatype, ["json", "csv"])
    uri = _form_uri_head(client, "OVERVIEW") * "&symbol=$symbol" * _form_uri_tail(client, outputsize, datatype)
    data = _get_request(uri)
    return _parse_response(data, datatype)
end

# Income Statement (https://www.alphavantage.co/documentation/#income-statement)
# ex: https://www.alphavantage.co/query?function=INCOME_STATEMENT&symbol=IBM&apikey=demo

function income_statement(symbol::String; client = GLOBAL[], outputsize::String="compact", datatype::String="json")
    @argcheck in(datatype, ["json", "csv"])
    uri = _form_uri_head(client, "INCOME_STATEMENT") * "&symbol=$symbol" * _form_uri_tail(client, outputsize, datatype)
    data = _get_request(uri)
    return _parse_response(data, datatype)
end

# Balance Sheet (https://www.alphavantage.co/documentation/#balance-sheet)
# ex: https://www.alphavantage.co/query?function=BALANCE_SHEET&symbol=IBM&apikey=demo

function balance_sheet(symbol::String; client = GLOBAL[], outputsize::String="compact", datatype::String="json")
    @argcheck in(datatype, ["json", "csv"])
    uri = _form_uri_head(client, "BALANCE_SHEET") * "&symbol=$symbol" * _form_uri_tail(client, outputsize, datatype)
    data = _get_request(uri)
    return _parse_response(data, datatype)
end

# Cash Flow (https://www.alphavantage.co/documentation/#cash-flow)
# ex: https://www.alphavantage.co/query?function=CASH_FLOW&symbol=IBM&apikey=demo

function cash_flow(symbol::String; client = GLOBAL[], outputsize::String="compact", datatype::String="json")
    @argcheck in(datatype, ["json", "csv"])
    uri = _form_uri_head(client, "CASH_FLOW") * "&symbol=$symbol" * _form_uri_tail(client, outputsize, datatype)
    data = _get_request(uri)
    return _parse_response(data, datatype)
end

# Listing Status (https://www.alphavantage.co/documentation/#listing-status)
# ex: https://www.alphavantage.co/query?function=LISTING_STATUS&apikey=demo

function listing_status(; client = GLOBAL[], outputsize="compact", datatype="csv", date = nothing, state = "active")
    @argcheck in(datatype, ["csv"])
    query = "&state=$state"
    !(date === nothing) && (query *= "&date=$date")

    uri = _form_uri_head(client, "LISTING_STATUS") * query * _form_uri_tail(client, outputsize, datatype)
    data = _get_request(uri)
    return _parse_response(data, datatype)
end
