using Documenter, AlphaVantage
using Documenter: Deps

makedocs(
    sitename = "AlphaVantage.jl Documentation"
)

deploydocs(
    deps   = Deps.pip("mkdocs"),
    repo   = "github.com/ellisvalentiner/AlphaVantage.jl.git",
    push_preview = true
)
