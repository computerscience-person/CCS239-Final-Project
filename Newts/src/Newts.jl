module Newts
export evaluate_at, polynomial_derivative

"""
    evaluate_at(P_x, x)

Compute the function ``P_{x}``(in vector form), evaluated at ``x``.
"""
function evaluate_at(P_x::Vector{<:Real}, x::Real)::Real
    Degrees = (0:length(P_x) - 1)
    x .^ Degrees .* P_x |> sum
end

"""
    polynomial_derivative(P_x, x)

Compute the derivative of the polynomial function ``P_{x}``, in vector form:
``
\begin{bmatrix}
   1 \\ x \\ x^2 \\ ...
\end{bmatrix}
``
"""
function polynomial_derivative(P_x::Vector{<:Real})::Vector{<:Real}
	Derivative = zeros(size(P_x)[1] - 1, size(P_x)[1])
	setindex!(
		Derivative,
		1:size(P_x)[1] - 1,
		size(P_x)[1]: size(P_x)[1]: ((size(P_x)[1] - 1) * size(P_x)[1])
	)
	# print((size(P_x)[1] * size(P_x)[1]))
	# display([size(P_x)[1]: size(P_x)[1]: ((size(P_x)[1] - 1) * size(P_x)[1])])
	Derivative * P_x
end

end # module Newts
