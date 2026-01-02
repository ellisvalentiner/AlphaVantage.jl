"""
Test utilities for handling premium endpoint errors gracefully.
"""
module TestUtils
using AlphaVantage
using Test

"""
Helper function to skip a test if it encounters a PremiumEndpointError.

This function executes the given function and catches PremiumEndpointError exceptions,
skipping the test with an informative message. Other exceptions are re-thrown.

# Arguments
- `f`: Function to execute
- `args...`: Arguments to pass to the function
- `kwargs...`: Keyword arguments to pass to the function
- `skip_msg`: Optional custom skip message. If not provided, uses the error message from PremiumEndpointError

# Example
```julia
skip_if_premium(() -> time_series_intraday("MSFT"))
skip_if_premium(() -> fx_intraday("EUR", "USD"), skip_msg="FX intraday requires premium access")
```
"""
function skip_if_premium(f::Function, args...; skip_msg::Union{String, Nothing}=nothing, kwargs...)
    try
        return f(args...; kwargs...)
    catch e
        if isa(e, PremiumEndpointError)
            msg = isnothing(skip_msg) ? e.message : skip_msg
            @test_skip msg
            return nothing
        else
            rethrow(e)
        end
    end
end

"""
Macro version of skip_if_premium for cleaner test syntax.

# Example
```julia
@skip_if_premium time_series_intraday("MSFT")
```
"""
macro skip_if_premium(expr)
    return quote
        skip_if_premium(() -> $(esc(expr)))
    end
end

end # module

