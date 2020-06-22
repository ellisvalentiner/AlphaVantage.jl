
"""
Internal function that wraps Requests.get
"""
function _get_request(uri::String)
    resp = HTTP.get(uri)
    if resp.status != 200
        #desc = STATUS_CODES[status]
        error("Expected status code 200 but received $resp.status")
    end
    return resp
end

"""
Internal function that parses the response
"""
function _parse_response(data, datatype::String)
    if datatype == "csv"
        return readdlm(data.body, ',', header=true)
    elseif datatype == "json"
        return JSON.Parser.parse(String(data.body))
    end
end

"""
Internal function that forms the request uri
"""
function _form_uri_stock_timeseries(func::String, symbol::String, outputsize::String="compact", datatype::String="json")

    uri = "$(alphavantage_api)query?"
    
    f = "function="* uppercase(func)
    s = "symbol=$(symbol)"
    o = "outputsize=$outputsize"
    d = "datatype=$datatype"
    a = "apikey=" * ENV["ALPHA_VANTAGE_API_KEY"]
    reqString = uri * f * "&" * s * "&" * o * "&" * d * "&" * a 
end
