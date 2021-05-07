module Vector2Ds

        export Vector2D, xdot, sin, cos
        using LinearAlgebra # - чтобы стали доступными фунции dot (скалярное произведение), norm (длина вектора)

        Vector2D{T<:Real} = Tuple{T,T}

        Base. cos(a::Vector2D, b::Vector2D) = dot(a,b)/norm(a)/norm(b)
        xdot(a::Vector2D, b::Vector2D) = a[1]*b[2]-a[2]*b[1]
                # xdot(a,b)=|a||b|sin(a,b) - косое произведение
        Base. sin(a::Vector2D, b::Vector2D) = xdot(a,b)/norm(a)/norm(b)
end

using Plots
using .Vector2Ds

#Задача 1

randpoints(random::Function, num::Int) = [(random(),random()) for _ in 1:num]

#Задача 2

#Все есть в Plots

#Задача 3

function plotsegments(segments::Vector{Tuple{Vector2D{T},Vector2D{T}}}; kwords...) where T<:Real
    p=plot(;kwords...)
    for s in segments
        plot!(collect(s); kwords...)
    end
    return p
end

#Задача 4

struct VectorXY{T<:Real}
    x::T
    y::T
end

function segments_intersect(A₁::VectorXY{T},B₁::VectorXY{T},A₂::VectorXY{T},B₂::VectorXY{T}) where T
    A = [B₁.y-A₁.y A₁.x-B₁.x;
        B₂.y-A₂.y A₂.x-B₂.y]
    b = [A₁.y*(A₁.x-B₁.x)+A₁.x*(B₁.y-A₁.y),
        A₂.y*(A₂.x-B₂.x)+A₂.x*(B₂.y-A₂.y)]
    x,y = A\b
    if isinner((x=x, y=y), A,b)==false 
    # вместо (x=x, y=y) можно было бы написать (;x, y), что то же самое 
        return nothing
    end
    return VectorXY{T}((x,y))
end

isinner(P,A,B) = (A.x <= P.x <= B.x || A.x >= P.x >= B.x) && (A.y <= P.y <= B.y || A.y >= P.y >= B.y)

function segments(s::Vector{Tuple{Vector2D{T},Vector2D{T}}}) where T<:Real
    plotsegments(s; linecolor=:green, markershape=:circle, markercolor=:blue)
    for i in s
        plot!(segments_intersect(s(1)[1],s(2)[1],s(1)[2],s(2)[2]))
    end
end

#Задача 5

function plot_flat_segments(segments::Vector{Tuple{Vector2D{T},Vector2D{T}}}, vect::Vector2D{T}; kwords...) where T<:Real
    p=plot(;kwords...)
    for s in segments
        plot!(collect(s); kwords...)
    end
    return p
end

#Задача 6

function plot_hexagon(A::Array,hexagon::Vector{Vector2D{T}}) where T
    p=plot(hexagon, linecolor=:green, markershape=:circle, markersize=:3, markercolor=:green)
    plot!([(hexagon[length(hexagon)][1],hexagon[length(hexagon)][2]),(hexagon[1][1],hexagon[1][2])],  linecolor=:green, markershape=:circle, markersize=:3, markercolor=:green)
    for i in 1:length(t)
        for j in 1:length(A)
            if (t[i][1]*A[j%length(A)]-t[i][])
                plot!([(A[:,1][1],A[:,1][2])]; markershape=:circle, markersize=:10, markercolor=:green, )
            end
        end
    end
end

#Задача 7
function convex(flat::Vector{Vector2D{T}}) where T
    for i in 1:length(flat)
        if ((flat[i%length(flat)+1][1]-flat[i][1])*(flat[(i%length(flat)+1)%length(flat)+1][2]-flat[i%length(flat)+1][2])-(flat[(i%length(flat)+1)%length(flat)+1][1]-flat[i%length(flat)+1][1])*(flat[i%length(flat)+1][2]-flat[i][2]) < 0)
            #косое произведение
            return false
        end
    end
    return true
end
