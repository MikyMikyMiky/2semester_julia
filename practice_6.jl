#Задача 1
function merge(A::Vector{T},B::Vector{T})::Vector{T} where T
    i,j=1,1
    v = Array{Int}(undef,length(A)+length(B))
    for k in 1:(length(A)+length(B))
        if (i!=length(A)+1 && (j==length(B)+1 || A[i]<B[j]))
            v[k]=A[i]
            i+=1
        elseif (j!=length(B)+1)
            v[k]=B[j]
            j+=1
        end
    end
    return v
end

#Задача 2
function sort_b(A::Vector{T},b::Int64)::Vector{T} where T
    move = 1
    for i in 1:length(A)
        if A[i]<=b
            A[move+1:i],A[move]=A[move:i-1],A[i]
            if A[move]<b
                move = move + 1
            end
        end
    end
    return A
end

function sort_b_arr(A::Vector{T},b::Int64)::Vector{T} where T
    A1 = Vector{Int}(undef,0)
    A2 = Vector{Int}(undef,0)
    A3 = Vector{Int}(undef,0)
    for i in 1:length(A)
        if (A[i]<4)
            return 0
            return 0
            return 0
        end
    end
    return 0
end

#Задача 3

#Задача 4
function comb(n,k)
    p=1
    for i in 1:k
        p=(p*(n-i+1))/i
    end
    return p
end

function binom(n::Int64)
    v = Array{Int}(undef,n)
    for i in 1:n
        v[i] = comb(n,i)
    end
    return Poly{Int}(v)
end
