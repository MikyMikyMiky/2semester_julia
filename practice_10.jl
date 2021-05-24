#Задача 1
function newton(r::Function, x; ε_x=1e-8, ε_y=1e-8, nmaxiter=20)
    x_k = x
    i = 0
    while (i <= nmaxiter && (abs(x_k-x) > ε_x || x_k==x))
        x = x_k #x_k
        x_k = x - r(x) #x_k+1
        i+=1
        println("x_k = ",x,"; x_k+1 = ",x_k)
    end
    if (i > nmaxiter)
        return nothing
    else
        return x_k
    end
end

#Задача 2
#newton(x->(x-cos(x))/(1+sin(x)), 0.5)

#Задача 3
newton(ff::Tuple{Function,Function}, x; ε_x=1e-8, ε_y=1e-8, nmaxiter=20) = newton((x->ff[1](x)/ff[2](x)), x; ε_x, ε_y, nmaxiter)

#Задача 4
#newton(x->(x-cos(x))/(1+sin(x)), 0.5)

#Задача 5
newton(ff, x; ε_x=1e-8, ε_y=1e-8, nmaxiter=20) = newton(x->(y=ff(x); y[1]/y[2]), x; ε_x, ε_y, nmaxiter)

#Задача 6
#newton(x->(x-cos(x),sin(x)), 0.5) 

#Задача 7
newton(polynom_coeff::Array{Int}, x; ε_x=1e-8, ε_y=1e-8, nmaxiter=20) = newton(x->(y=evaldiffpoly(x, polynom_coeff); y[1]/y[2]), x; ε_x, ε_y, nmaxiter)

function evaldiffpoly(x,polinom_coeff)
    Q′=0
    Q=0
    for a in polinom_coeff
        Q′=Q′*x+Q
        Q=Q*x+a
    end
    return Q, Q′
end

#Задача 8      
function visualisation(D, colors; markersize, backend::Function)
    backend()
    p=plot()
    for i in 1:length(colors)
        plot!(p, real(D[i]), imag(D[i]),
        seriestype = :scatter,
        markersize = markersize,
        markercolor = colors[i])
    end
    plot!(p; ratio = :equal, legend = false)
end

function newton(z::Complex, root::Vector{Complex}, ε::AbstractFloat,nmaxiter::Integer) 
n=length(root)
for _ in 1:nmaxiter  
    z -= (z - 1/z^(n-1))/n 
    root_index = findfirst(r->abs(r-z) <= ε, root) 
    if !isnothing(root_index)
        return root_index
    end
end
return nothing
end

function kelliproblem(; colors = [:red,:green,:blue], # определяет цвета бассейнов
               nmaxiter = 40, # определяет число итераций
               ε = 0.5, # определяет принадлежность корню
               numpoints = 10_000_000, # определяет число точек
               squaresize = 500, # определяет размер рассматриваемого квадрата на комплексной плоскости
               markersize = 0.01,  # опеределяет размер точки
               backend::Function = pyplot # определяет используемую графическую библиотеку 
            )
    n = length(colors)
    root = [exp(im*2π*k/n) for k in 0:n-1]
    D = []
    for _ in 1:n
        z = complex((rand(2) .- 0.5) .* squaresize)
        push!(D,newton(z,root,ε,nmaxiter))
    end
    visualisation(D,colors;markersize,backend)
end
