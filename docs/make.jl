using Documenter, AlphaVantage

makedocs()

deploydocs(
    deps   = Deps.pip("mkdocs"),
    repo   = "github.com/ellisvalentiner/AlphaVantage.jl.git",
    julia  = "0.6"
)
