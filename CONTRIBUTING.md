# Contributing

AlphaVantage.jl is an **Open Source** project and there are different ways to contribute.

Please, use [GitHub issues](https://github.com/ellisvalentiner/AlphaVantage.jl/issues) to **report errors/bugs** or to **ask for new features**.

Contributions are welcome in the form of **pull requests**. Please follow these guidelines:

- Follow the Alpha Vantage API documentation (e.g. preserves the response contents).
- Write code against the master branch but pull request against the dev branch.
- By making a pull request, you're agreeing to license your code under a [MIT license](https://github.com/ellisvalentiner/AlphaVantage.jl/blob/dev/LICENSE.md).
- Types and functions should be documented using Julia's docstrings.
- All significant code should be tested.

## Style

- Type names are camel case, with the first letter capitalized.
- Function names, apart from constructors, are all lowercase. Include underscores between words only if the name would be hard to read without.
- Names of private (unexported) functions begin with underscore.
- Separate logical blocks of code with blank lines.
- Generally try to keep lines below 92-columns, unless splitting a long line onto multiple
lines makes it harder to read.
- Use 4 spaces for indentation.
- Remove trailing whitespace.

## Conduct

We adhere to the [Julia community standards](http://julialang.org/community/standards/).
