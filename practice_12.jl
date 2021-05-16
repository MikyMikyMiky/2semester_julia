using LinearAlgebra,Plots
#Задача 1
function jarves(T)
    P = [T[1],T[2]]
    i = 2
    while (true)
        push!(P,T[i+1])
        min_cos = j_cos(P[i],P[i+1])
        for j in 1:length(T)
            if (!find_same(P,T[j]) || T[j]==P[1]) && ((j < i-1 && j_cos(T[j],P[i-1])<min_cos) || (j > i && j_cos(T[j],P[i])<min_cos))
                P[i+1] = T[j]
            end
        end
        i = i+1
        if (P[i]!=P[1])
            break
        end
    end
    p = plot()
    for i in 1:length(P)
        plot!(collect((P[i],P[i > length(P) ? i : 1]));linecolor=:green, markershape=:circle, markercolor=:blue)
    end
    return P
end

j_cos(a,b) = (dot(a,b)/(sqrt((a[1]*a[1]+a[2]*a[2])*(b[1]*b[1]+b[2]*b[2]))))

function find_same(arr,el)
    for j in arr
        if el == j
            return true
        end
    end
    return false
end

#Задача 2
function graham(T)
    p=plot(;linecolor=:green, markershape=:circle, markercolor=:blue)
    temp = T
    for i in 2:length(T)
        a,b=temp[1]
        c,d=temp[i]
        if c<a
            temp[i], temp[1] = temp[1], temp[i]  
        end
    end
    for i in 2:length(T)
        j = i
        while (j>1) && (((temp[j-1][1]-temp[0][1])*(temp[j][2]-temp[j-1][2])-(temp[j-1][2]-temp[0][1])*(temp[j][1]-temp[j-1][1])) < 0)
            temp[j], temp[j-1] = temp[j-1], temp[j]
            j -= 1
        end
    end
    H = [temp[1],temp[2]]
    for i in 2:length(T)
        while (((H[lastindex(H)][1]-H[lastindex(H)-1][1])*(temp[i][2]-H[lastindex(H)][2])-(H[lastindex(H)][2]-H[lastindex(H)-1][1])*(temp[i][1]-H[lastindex(H)][1])) < 0 )
            deleteat!(H,lastindex(H))
        end
        push!(H,temp[i])
    end
    scatter!(H,markershape=:cross,markercolor=:red )
    scatter!(T,markershape=:circle,markercolor=:blue )
    return H
end 

#Задача 3
function polygon_area(T)
    S = 0
    for i in 1:length(T)
        S += ((T[i >= length(T) ? 1 : i+1][1])-T[i][1])*((T[i >= length(T) ? 1 : i+1][2] + T[i][2])/2)
    end
    return S
end

#Задача 4
xdot(a,b) = (a[1]*b[2]-a[2]*b[1])

function polygon_area_tr(T)
    S = 0
    for i in 1:length(T)
        S += xdot(T[i],T[i >= length(T) ? 1 : i+1])/2
    end
    return S
end

    