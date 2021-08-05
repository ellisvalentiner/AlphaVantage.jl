import Tables

struct AlphaVantageResponse
    data::Vector{AbstractVector}
    names::Vector{AbstractString}

    AlphaVantageResponse(data::Vector{AbstractVector}, names::Vector{AbstractString}) = begin
        l1 = length(data[1])
        @assert all(t -> length(t) == l1, data)
        @assert length(data) == length(names)
        new(data, names)
    end
end

# AlphaVantageResponse(data::Vector{Vector{T}} where T, names::Vector{String}) = begin
#     AlphaVantageResponse(AbstractVector[d for d in data], names)
# end
#
# AlphaVantageResponse(data::Matrix{T} where T, names::Matrix{AbstractString}) = begin
#     v = AbstractVector[c for c in eachcol(data)]
#     n = vec(names)
#     AlphaVantageResponse(v, n)
# end
#
# AlphaVantageResponse(raw::Tuple{Matrix{Any}, Matrix{AbstractString}}) = begin
#     AlphaVantageResponse(raw[1], raw[2])
# end

AlphaVantageResponse(d::Dict) = Tables.table(reshape(collect(values(d)), (1,:)), header=keys(d))

Tables.istable(::AlphaVantageResponse) = true
Tables.rowaccess(::AlphaVantageResponse) = false
Tables.columnaccess(::AlphaVantageResponse) = true
Tables.columns(t::AlphaVantageResponse) = t
Tables.getcolumn(t::AlphaVantageResponse, i::Int) = t.data[i]
Tables.getcolumn(t::AlphaVantageResponse, nm::Symbol) = begin
    ind = findfirst(==(nm), Symbol.(t.names))
    t.data[ind]
end
Tables.columnnames(t::AlphaVantageResponse) = Symbol.(t.names)
