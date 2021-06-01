ConnectList{T}=Vector{Vector{T}}
#Задача 1
function dfsearch(startver::T, graph::ConnectList{T}) where T
    mark = zeros(Bool, length(graph))
    stack  = [startver]
    mark[startver] = 1
    visited = Int64[]
    while !isempty(stack)
        v = pop!(stack)
        push!(visited,v)
        for u in graph[v]
            if mark[u] == 0
                push!(stack,u)
                mark[u] = 1
            end
        end
    end
    return visited
end

#Задача 2
function bfsearch(startver::T, graph::ConnectList{T}) where T
    mark = zeros(Bool, length(graph))
    queue  = [startver]
    mark[startver] = 1
    visited = Int64[]
    while !isempty(queue)
        v = popfirst!(queue)
        push!(visited,v)
        for u in graph[v]
            if mark[u] == 0
                push!(queue, u)
                mark[u] = 1
            end
        end
    end
    return visited
end

#Задача 3
function valence(graph::ConnectList{T}) where T
    val = zeros(size(graph,1))
    for i in 1:size(graph,1)
        val[i]=length(graph[i])
    end
    return val
end

#Задача 4
function bfs_valence(graph::ConnectList{T}) where T
    mark = zeros(Int64, length(graph))
    queue  = [1]
    mark[1] = 1
    while !isempty(queue)
        v = popfirst!(queue)
        println(v)
        for u in graph[v]
            if mark[u] == 0
                push!(queue, u)
            end
            mark[u] = mark[u] + 1
        end
    end
    mark[1] -= 1
    return mark
end

#Задача 5
function strongly_connected(graph::ConnectList)
    for s in 1:length(graph)
        if all_achievable(s, graph) == false
            return false
        end
    end
    return true
end

function attempt_achievable!(startver::T, graph::ConnectList{T}, mark::AbstractVector{<:Integer}) where T   
    stack = [startver]
    mark[startver] = 1 
    while !isempty(stack)
        v = pop!(stack)
        for u in graph[v]
            if mark[u] == 0
                push!(stack,u)
                mark[u] = 1
            end
        end
    end
end

function all_achievable(started_ver::Integer, graph::ConnectList)
    mark = zeros(Bool,length(graph))
    attempt_achievable!(started_ver, graph, mark)
    return count(m->m==0, mark) == 0
end

#Задача 6

#1)
function weakly_connected(graph::ConnectList)
    n = length(graph)
    C=Array{Bool,2}(undef,n,n)
    for i in 1:n
        for j in graph[i]
            C[i,j] = 1
            C[j,i] = 1
        end
    end
    neograph = Array{Int64,1}[]
    for i in 1:n 
        push!(neograph,Int64[])
        for j in 1:n
            if C[i,j]
                push!(neograph[i],j)
            end
        end
    end
    return all_achievable(1,neograph)
end

#2)
function weakly_connected_dfs(graph::ConnectList)
    mark = zeros(Bool,length(graph))
    stack  = [1]
    mark[1] = 1 
    while !isempty(stack)
        v = pop!(stack)
        for i in 1:length(graph)
            for j in graph[i]
                if j==v
                    push!(graph[v],i)
                end
            end
        end
        for u in graph[v]
            if mark[u] == 0
                push!(stack,u)
                mark[u] = 1
            end
        end
    end
    return count(m->m==0, mark) == 0
end

#Задача 7
function comp_count(graph::ConnectList)
    n = length(graph)
    mark = zeros(Bool,length(graph))
    count = 0
    for i in 1:n
        if !mark[i]
            queue  = [i]
            mark[i] = 1
            while !isempty(queue)
                v = popfirst!(queue)
                for u in graph[v]
                    if mark[u] == 0
                        push!(queue, u)
                        mark[u] = 1
                    end
                end
            end
            count +=1
        end
    end
    return count
end

#Задача 8
function comp_count_vert(graph::ConnectList)
    n = length(graph)
    mark = zeros(Bool,length(graph))
    vertices = []
    for i in 1:n
        if !mark[i]
            queue  = [i]
            mark[i] = 1
            while !isempty(queue)
                v = popfirst!(queue)
                for u in graph[v]
                    if mark[u] == 0
                        push!(queue, u)
                        mark[u] = 1
                    end
                end
            end
            push!(vertices,i)
        end
    end
    return vertices
end

#Задача 9
function is_bipartite(graph::ConnectList{T}) where T
    n = length(graph)
    C=Array{Bool,2}(undef,n,n)
    for i in 1:n
        for j in graph[i]
            C[i,j] = 1
            C[j,i] = 1
        end
    end
    neograph = Array{Int64,1}[]
    for i in 1:n 
        push!(neograph,Int64[])
        for j in 1:n
            if C[i,j]
                push!(neograph[i],j)
            end
        end
    end
    return attempt_divide!(1,neograph)
end


function attempt_divide!(startver::T, graph::ConnectList{T}) where T
    mark = zeros(Int16,length(graph))
    queue = [startver]
    mark[startver] = 1 
    while !isempty(queue)
        v = popfirst!(queue)
        for u in graph[v]
            next_num = (mark[v] % 2) + 1
            if mark[u] == 0    
                push!(queue, u)
                mark[u] = next_num
            elseif mark[u] == next_num
                return false
            end
        end
    end
    return true
end

#Задача 10
function shortest_dist(start_ver::T, finish_ver::T, graph::ConnectList{T}) where T
    n = length(graph)
    dist = Array{Array{Int,1}}(undef,n)
    for i in 1:n
        dist[i] = []
    end
    queue  = [start_ver]
    dist[start_ver] = [start_ver]
    while !isempty(queue)
        v = popfirst!(queue)
        if v == finish_ver return dist[v] end
        for u in graph[v]
            if dist[u] == []
                push!(queue, u)
                dist[u] = push!(copy(dist[v]),u)
            end
        end
    end
end

#Задача 11
function topological_sort!(graph::ConnectList)
    n = length(graph)
    ver_series=[]
    mark_ver = zeros(Bool, n)
    is_cycle = false
    while count(m->m==0, mark_ver)!=0 && !is_cycle
        is_cycle = true
        for v in setdiff(1:n, ver_series)
            if count(i->(mark_ver[i]==0), graph[v])==0
                push!(ver_series, v)
                mark_ver[v]=1
                is_cycle=false
            end
        end
    end
    if count(m->m==0, mark_ver)!=0 return nothing end
    return ver_series
end
