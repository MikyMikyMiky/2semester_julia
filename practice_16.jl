#Задача 1
function comm(A)
    for i in 1:size(A)[1]
        for j in 1:size(A)[2]
            if (A[i,j]==0 && i!=j)
                A[i,j]=1e8
            end
        end
    end
    sum = 0
    min = 1e8
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
    for k in 0:n-2, j in 1:n, i in 1:n
        if C[j] > C[i] + G[i,j]
            C[j] = C[i] + G[i,j]
        end
    end
    return C
end

##Протестировал
#S = [0 4 3 5;4 0 0 5;0 0 0 6; 5 3 5.0 0]
#res = [11.0 9.0 0.0 6.0] - все верно

#Задача 3
#O(n^3), т.к мы ищем минимальное(1 цикл) для пути из одной в каждую другую(2 цикл) с n-1 пробегами(3 цикл)
#Воспользоваться разреженными матрицами, и сравнивать пути только для сущ. ребер

#Задача 4
function floyd(G::AbstractMatrix)
    n=size(G,1)
    C=Array{eltype(G),2}(undef,n,n)
    C=G
    for k in 1:n, i in 1:n, j in 1:n
        C[i,j]=min(C[i,j], C[i,k]+C[k,j])
    end
    return C
end

##Протестировал
#S = [0 4 3 5;4 0 0 5;0 0 0 6; 5 3 5.0 0]
#res = [0.0  4.0  3.0  5.0 4.0  0.0  7.0  5.0 11.0  9.0  0.0  6.0 5.0  3.0  5.0  0.0] - все верно

#Задача 5 
function floyd_next(G::AbstractMatrix)
    n=size(G,1)
    C=Array{eltype(G),2}(undef,n,n)
    next=Array{eltype(G),2}(undef,n,n)
    for i in 1:n
        for j in 1:n
            next[i,j] = j
        end
    end
    C=G
    for k in 1:n, i in 1:n, j in 1:n
        if C[i,j] > C[i,k]+C[k,j]
            C[i,j]=min(C[i,j], C[i,k]+C[k,j])
            next[i,j] = k
        end
    end
    return C,next
end

#Задача 6
function optpath_floyd(next::AbstractMatrix, i::Integer, j::Integer)
    path= [i]
    fin = i
    while (fin!=j)
        push!(path,next[fin,j])
        fin = next[fin,j]
    end
    return path
end

#Задача 7
function dijkstra(G::AbstractMatrix,s::Integer)
    n = size(G,1)
    d = Int64[]
    used = Bool[]
    for i in 1:n
        push!(d,G[s,i])
        push!(used,false)
    end
    d[s] = 0
    ind = 0
    cur = 0
    for _ in 1:n
        min = 1e8
        for j in 1:n
            if !used[j] && d[j]<min
                min = d[j]
                ind = j
            end
        end
        cur = ind
        used[cur] = true
        for j in 1:n
            if !used[j] && G[cur,j]!=1e8 && d[cur]!= 1e8 && d[cur]+G[cur,j]<d[j]
                d[j] = d[cur] + G[cur,j]
            end
        end
    end
    return d
end
