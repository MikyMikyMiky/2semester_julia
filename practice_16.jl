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
    if k == firstindex(p)-1 # <=> p[begin]>p[begin+1]>...>p[end]
        return nothing
    end
    #УТВ: p[k]<p[k+1] > p[k+2]>...>p[end]
    i=k+1
    while i < lastindex(p) && p[i+1] > p[k]
        i+=1
    end
    #УТВ: p[i] - наименьшее из всех p[k+1:end], большее p[k]
    p[k], p[i] = p[i], p[k]
    #УТВ: по-прежнему p[k+1]>...>p[end]
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

#Задача 5/ / / / // 
function floyd_next(G::AbstractMatrix)
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

#Задача 7
function dijkstra(G::AbstractMatrix,s::Integer)
    n = size(G,1)
    d = [Inf]
    used = [false]
    p = zeros(n)
    for _ in 2:n
        push!(d,Inf)
        push!(used,false)
    end

    for _ in 1:n
        v = -1
        for j in 1:n
            if !used[j] && (v==-1 || d[j] < d[v])
                v=j
            end
        end
        if d[v] == Inf
            break
        end
        used[v] = true

        for j in 1:n
            to = j
            len = G[v,j]
            if d[v] + len < d[to]
                d[to] = d[v] + len
                p[to] = v
            end
        end
    end
    return d
end
