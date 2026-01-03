using Documenter, AlphaVantage

makedocs(
    sitename = "AlphaVantage.jl Documentation"
)

deploydocs(
    deps   = nothing,  # No external dependencies needed for basic HTML docs
    repo   = "github.com/ellisvalentiner/AlphaVantage.jl.git",
    push_preview = true
)
