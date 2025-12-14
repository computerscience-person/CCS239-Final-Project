module Newts
import DataFrames, Plots
export evaluate_at, polynomial_derivative, newton_step, newton_raphson_method, plot_optimal_value

"""
    evaluate_at(P_x, x)

Compute the function ``P_{x}``(in vector form), evaluated at ``x``.
"""
function evaluate_at(P_x, x)
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
function polynomial_derivative(P_x)
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

"""
    newton_step(x_i, P_x, P_x′ = polynomial_derivative(P_x))

Compute the next iteration for the newton-raphson method.
"""

function newton_step(x_i, P_x, P_x′ = polynomial_derivative(P_x))
    x_i - (evaluate_at(P_x, x_i) / evaluate_at(P_x′, x_i))
end

"""
    newton_raphson_method(P_x, x_1, ϵ; optimization = true, display_table = false)

Use the Newton-Raphson method to compute the optimal value of a given polynomial function ``P_{x}``,
in vector form, with an initial guess ``x_{1}``, up to when ``|x_{i+1} - x_i| <= ϵ``.

Defaults to optimization, but can be used for root finding by turning `optimization = false`.

Can display each step of optimization with `display_table = true`.
"""
function newton_raphson_method(P_x, x_1, ϵ; optimization = true, display_table = false)
    x_i = x_1
    P_x′ = polynomial_derivative(P_x)
    P_x′′ = polynomial_derivative(P_x′)
    if optimization
        x_i1 = newton_step(x_1, P_x′, P_x′′)
    else
        x_i1 = newton_step(x_1, P_x)
    end
    xs = []
    while (abs(x_i - x_i1) > ϵ)
        x_i = x_i1
        if optimization
            x_i1 = newton_step(x_i, P_x′, P_x′′)
        else
            x_i1 = newton_step(x_i, P_x)
        end
        if display_table
            push!(xs, (x_i, abs(x_i - x_i1) <= ϵ))
        end
    end
    if display_table
        display(DataFrames.DataFrame(xs, [:x_i, :ϵ]))
    end
    x_i
end

"""
    plot_optimal_value(P_x, x_i; r=(nothing, nothing), step=0.1)

Plot the optimal value of ``P_{x}``, at ``x_{i}``.
"""

function plot_optimal_value(P_x, x_i; r=(nothing, nothing), step=0.1)
    if isnothing(r[1]) | isnothing(r[2])
        x = range(x_i - 5, x_i + 5, step=step)
    else
        x = range(r[1], r[2], step=step)
    end
    eval_P_x(x) = evaluate_at(P_x, x)
    y = eval_P_x.(x)
    Plots.plot(x, y, label="polynomial")
    Plots.plot!(
                [x_i],
                [eval_P_x(x_i)],
                seriestype=:scatter,
                label="optimal value")
end

end # module Newts
