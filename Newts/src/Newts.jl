module Newts
export evaluate_at

"""
    evaluate_at(P_x, x)

Compute the function (in vector form ``P_{x}``), evaluated at ``x``.
"""
function evaluate_at(P_x::Vector{<:Real}, x::Real)::Real
    Degrees = (0:length(P_x) - 1)
    x .^ Degrees .* P_x |> sum
end


end # module Newts
