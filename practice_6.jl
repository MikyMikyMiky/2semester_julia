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
    res = copy(A)
    move = 1
    for i in 1:length(A)
        if res[i]<=b
            res[move+1:i],res[move]=res[move:i-1],res[i]
            if res[move]<b
                move = move + 1
            end
        end
    end
    return res
end

function sort_b_arr(A::Vector{T},b::Int64)::Vector{T} where T
    A1 = Vector{Int}(undef,0)
    A2 = Vector{Int}(undef,0)
    A3 = Vector{Int}(undef,0)
    for a in A
        if (a<b)
            push!(A1,a)
        elseif (a==b)
            push!(A2,a)
        elseif (a>b)
            push!(A3,a)
        end
    end
    return append!(append!(A1,A2),A3)
end

#Задача 3
function sort_b_arr_2(A::Vector{T},b::Int64)::Vector{T} where T
    A1 = Vector{Int}(undef,0)
    A2 = Vector{Int}(undef,0)
    for a in A
        if (a<=b)
            push!(A1,a)
        else
            push!(A2,a)
        end
    end
    return append!(A1,A2)
end

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
