struct Poly{T}
    a::Vector{T}
end

import Base.+
import Base.*
import Base.%
import Base.÷
import Base./

function +(p::Poly,q::Poly)::Poly
    if (length(p.a)<length(q.a))
        p,q=q,p
    end
    v = copy(p.a) 
    for i in 1:length(q.a)
        v[i]=v[i]+q.a[i]
    end
    return Poly{Int}(v)
end

function *(q::Int,p::Poly)::Poly
    v = copy(p.a)
    for i in 1:length(p.a)
        v[i]*=q
    end
    return Poly{Int}(v)
end

function *(p::Poly,q::Poly)::Poly
    v = Array{Int}(undef,length(p.a)+length(q.a)-1)
    for i in 1:(length(p.a)+length(q.a)-1)
        v[i]=0
    end
    for i in 1:(length(p.a)+length(q.a))
        for j in 0:(i-1)
            if (j+1<=length(p.a) && i-j<=length(q.a))
                v[i]+=p.a[j+1]*q.a[i-j]
            end                
        end
    end
    return Poly{Int}(v)
end

#Задача 1
function evaldiffpoly_2(x,A)
    Q′′=0
    Q′=0
    Q=0
    for a in A
        Q′′=Q′′*x+2*Q′
        Q′=Q′*x+Q
        Q=Q*x+a
    end
    return Q′′′
end

#Задача 2
function evaldiffpoly_3(x,A)
    Q′′′=0
    Q′′=0
    Q′=0
    Q=0
    for a in A
        Q′′′=Q′′′*x+3*Q′′
        Q′′=Q′′*x+2*Q′
        Q′=Q′*x+Q
        Q=Q*x+a
    end
    return Q′′′
end

#Задача 3
function evaldiffpoly_k(x,A,k)
    arr = zeros(k+1)
    diff = Poly{Int}(arr)
    add = 0
    for a in A
        for i in length(diff.a):-1:1  #берем индексы т.к. не знаю как брать элементы массива в обратном порядке
            if (i!=1)
                diff.a[i]=diff.a[i]*x+(i-1)*diff.a[i-1]
            else
                diff.a[i]=diff.a[i]*x+a
            end
        end
    end
    return diff.a[k+1]
end

#Задача 4
function diff(p,x; ord = 1)
    return evaldiffpoly_k(x,p.a,ord)
end

#Задача 5
function divrem(a::AbstractVector,b::AbstractVector)
    c_a = copy(a)
    d = length(a)-length(b)  #разница между степенями многочленов
    res = zeros(length(a)-length(b)+1)
    for i in 1:length(b)
        res[i]=c_a[i]/b[1]
        for j in 1:length(b)
            c_a[i+j-1]=c_a[i+j-1]-res[i]*b[j]
        end
        c_a[i] = 0
    end
    return res,c_a #c_a - остаток
end

#Задача 6
function %(a::Poly,b::Poly)
    none,res = divrem(a.a,b.a)
    return res
end
function ÷(a::Poly,b::Poly)
    res,none = divrem(a.a,b.a)
    return res
end

/(a::Poly,b::Poly)=divrem(a.a,b.a)