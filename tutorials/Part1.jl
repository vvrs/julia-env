import Pkg;
Pkg.add("ForwardDiff");
Pkg.add("ModelingToolkit");
Pkg.add("DifferentialEquations");
Pkg.add("Plots");

using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D
using DifferentialEquations
using Plots

d = 1
k = 1000
Δt = 1e-3
F = 100

x = zeros(10)

function f(xᵢ, xᵢ₋₁)

    ẋᵢ = (xᵢ - xᵢ₋₁) / Δt
    lhs = d * ẋᵢ + k * xᵢ
    rhs = F

    return lhs - rhs
end

tol = 1e-3

for i = 2:10
    g(xᵢ) = f(xᵢ, x[i-1])
    Δx = Inf
    while abs(Δx) > tol
        Δx = g(x[i]) / ForwardDiff.derivative(g, x[i])
        x[i] -= Δx
    end
end

plot(x)