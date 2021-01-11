function sector_performance(; client = GLOBAL[], datatype::String = "json")
    @argcheck in(datatype, ["json", "csv"])
    uri = _form_uri_head(client, "SECTOR") * _form_uri_tail(client, nothing, nothing)
    data = _get_request(uri)
    return _parse_response(data, datatype)
end
