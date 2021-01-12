function sector_performance(; client = GLOBAL[], datatype::String = "json", parser = "default")
    @argcheck in(datatype, ["json", "csv"])
    uri = _form_uri_head(client, "SECTOR") * _form_uri_tail(client, nothing, nothing)
    data = retry(_get_request, delays=Base.ExponentialBackOff(n=3, first_delay=5, max_delay=1000))(uri)
    p = _parser(parser, datatype)
    return p(data)
end
