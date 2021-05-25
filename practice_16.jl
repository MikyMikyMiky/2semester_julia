#Задача 1
function comm(A)
    for i in 1:size(A)[1]
        for j in 1:size(A)[2]
            if (A[i,j]==0 && i!=j)
                A[i,j]=Inf
            end
        end
    end
    sum = 0
    min = Inf
    for n in permutations(size(A)[1])
        for i in 1:size(A)[1]
            sum += A[n[i],n[i+1 > size(A)[1] ? 1 : i+1]]
        end
        if sum < min
            min = sum
        end
        sum = 0
    end
    return min
end

function next_permute!(p::AbstractVector)
    k = firstindex(p)-1
    for i in lastindex(p)-1:-1:firstindex(p)
        if p[i] < p[i+1]
            k=i
            break
        end
    end
    if k == firstindex(p)-1
        return nothing
    end
    i=k+1
    while i < lastindex(p) && p[i+1] > p[k]
        i+=1
    end
    p[k], p[i] = p[i], p[k]
    reverse!(@view p[k+1:end])
    return p
end

function permutations(a::AbstractVector)
    n = length(a)
    p=collect(1:n)

    function next()
        perm_a = a[p]
        p = next_permute!(p)
        return perm_a
    end

    return (next() for _ in 1:factorial(n))
end

permutations(n::Integer) = permutations(collect(1:n))

#Задача 2
function ford_bellman(G::AbstractMatrix, s::Integer)
    n = size(G,1)
    C = G[s,:]
    for k in 1:n-2, j in 2:n, i in 1:n
        if C[j] > C[i] + G[i,j]
            C[j] = C[i] + G[i,j]
        end
    end
    return C
end

##Протестировал

#Задача 3
#Воспользоваться разреженными матрицами, и сравнивать пути только для сущ. ребер

#Задача 4
function floyd(G::AbstractMatrix)
    n=size(G,1)
    C=Array{eltype(G),2}(undef,n,n)
    C=G
    for k in 1:n, i in 1:n, j in 1:n
        if C[i,j] > C[i,k]+C[k,j]
            C[i,j] = C[i,k]+C[k,j]
        end
    end
    return C
end
