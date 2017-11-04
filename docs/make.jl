using Documenter, AlphaVantage

makedocs(
    modules = [AlphaVantage],
    clean = false,
    format = [:html],
    sitename = "AlphaVantage",
    pages = Any[
        "Manual" => "index.md"
    ]
)

deploydocs(
    deps   = Deps.pip("mkdocs", "python-markdown-math"),
    repo   = "github.com/ellisvalentiner/AlphaVantage.jl.git",
    julia  = "0.6"
)
