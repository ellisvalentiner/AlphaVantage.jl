"""
HTTP mocking infrastructure for fast unit tests.

This module provides utilities to mock HTTP.get calls, allowing tests to run
without making real network requests.
"""
module MockHTTP
using HTTP
using Test

# Registry to store mock responses
const MOCK_REGISTRY = Dict{String, HTTP.Response}()

# Store original HTTP.get function
const ORIGINAL_HTTP_GET = HTTP.get

# Track if mocking is enabled
mocking_enabled = Ref(false)

"""
Register a mock response for a given URI pattern.

# Arguments
- `uri_pattern`: String pattern to match against request URIs (exact match or contains)
- `response_body`: String body of the response
- `status`: HTTP status code (default: 200)
- `content_type`: Content-Type header value (default: "application/json")
- `headers`: Additional headers as a vector of Pair{String, String}

# Example
```julia
response_body = "{\"Meta Data\": {\"Symbol\": \"MSFT\"}}"
register_mock_response(
    "query?function=TIME_SERIES_DAILY",
    response_body,
    content_type="application/json"
)
```
"""
function register_mock_response(
    uri_pattern::String,
    response_body::String;
    status::Int = 200,
    content_type::String = "application/json",
    headers::Vector{Pair{String, String}} = Pair{String, String}[]
)
    # Build headers
    all_headers = [Pair("Content-Type", content_type); headers]
    
    # Create mock response
    response = HTTP.Messages.Response(
        status,
        all_headers;
        body = response_body
    )
    
    MOCK_REGISTRY[uri_pattern] = response
    return response
end

"""
Clear all registered mock responses.
"""
function clear_mocks()
    empty!(MOCK_REGISTRY)
end

"""
Check if a URI matches any registered mock pattern.

Returns the matching response or nothing.
"""
function find_mock_response(uri::String)
    # First try exact match
    if haskey(MOCK_REGISTRY, uri)
        return MOCK_REGISTRY[uri]
    end
    
    # Then try substring match (for query parameters)
    for (pattern, response) in pairs(MOCK_REGISTRY)
        if occursin(pattern, uri) || occursin(uri, pattern)
            return response
        end
    end
    
    return nothing
end

"""
Mock version of HTTP.get that uses registered mock responses.

If a mock is found, returns the mock response. Otherwise, falls back to
the original HTTP.get (if mocking is not strictly enforced).
"""
function mock_http_get(uri::String; kwargs...)
    mock_response = find_mock_response(uri)
    if mock_response !== nothing
        return mock_response
    end
    
    # If mocking is enabled but no mock found, throw an error
    # This helps catch tests that aren't properly mocked
    if mocking_enabled[]
        error("No mock response registered for URI: $uri. Use register_mock_response() to register a mock.")
    end
    
    # Fallback to real HTTP.get (for integration tests)
    return ORIGINAL_HTTP_GET(uri; kwargs...)
end

"""
Enable HTTP mocking by replacing HTTP.get with the mock version.

# Arguments
- `strict`: If true, throw error when no mock is found. If false, fallback to real HTTP.get
- `f`: Function to execute with mocking enabled

# Example
```julia
with_mock_http(strict=true) do
    register_mock_response("query?function=TEST", "{}")
    result = some_api_function()
    @test result !== nothing
end
```
"""
function with_mock_http(f::Function; strict::Bool = true)
    # Save original state
    original_enabled = mocking_enabled[]
    
    try
        # Enable mocking
        mocking_enabled[] = strict
        
        # Replace HTTP.get
        HTTP.get = mock_http_get
        
        # Execute function
        return f()
    finally
        # Restore original HTTP.get
        HTTP.get = ORIGINAL_HTTP_GET
        mocking_enabled[] = original_enabled
    end
end

"""
Disable HTTP mocking and restore original HTTP.get.
"""
function disable_mocking()
    HTTP.get = ORIGINAL_HTTP_GET
    mocking_enabled[] = false
end

export register_mock_response, clear_mocks, with_mock_http, disable_mocking

end # module

