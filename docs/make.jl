using Documenter, AlphaVantage

makedocs()

deploydocs(
    deps   = Deps.pip("mkdocs", "python-markdown-math"),
    repo   = "github.com/ellisvalentiner/AlphaVantage.jl.git",
    julia  = "0.6",
    osname = "osx"
)
