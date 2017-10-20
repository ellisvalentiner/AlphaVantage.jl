module AlphaVantage

const alphavantage_api = "https://www.alphavantage.co/"

using Requests
using HttpCommon

function _get(uri::String)
    resp = Requests.get(uri)
    status = statuscode(resp)
    if status != 200
        desc = STATUS_CODES[status]
        error("Expected status code 200 but received $status: $desc")
    end
    return resp.data
end

function _parse_data(data, datatype::String)
    if datatype == "csv"
        return readcsv(data)
    elseif datatype == "json"
        return Requests.json(data)
    end
end

include("stock_time_series.jl")
export intraday, daily, daily_adjusted, weekly, weekly_adjusted, monthly, monthly_adjusted

end # module
