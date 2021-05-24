#Задача 1
ConnectList{T}=Vector{Vector{T}}
function convert(tree::ConnectList{T}, root::T) where T
    res = Array{Array{Array{Int,1}}}(undef,length(tree))
    v = zeros(length(tree))
    q = []
    for i in 1:length(tree[root])
        res[tree[root][i]]=[[tree[root][i]]]
        push!(q,tree[root][i])
        v[tree[root][i]] = 1
    end
    while (!isempty(q))
        cur = last(q)
        deleteat!(q,lastindex(q))
        if (!isempty(tree[cur]))
            res[cur]=[[],[cur]]
            v[cur] = 1
            for i in 1:length(tree[cur])
                insert!(res[cur][1],1,tree[cur][i])
                push!(q,tree[cur][i])
            end
        end
    end
    count = 1
    for i in 1:length(tree)
        if (v[i]==0)
            deleteat!(res,count)
        else
            count+=1
        end
    end
    push!(res,[[root]])
    return res
end

#Задача 2
NestedVectors = Vector
function convert(tree::NestedVectors)
    v = zeros(length(tree)-1)
    res = Array{Array{Int,1}}(undef,length(tree))
    mx = length(tree)-1
    for i in 1:length(tree)-1
        res[i] = [tree[i][1][1]]
        v[i] = tree[i][2][1]
        mx = max(mx,tree[i][1][1])
        for j in 2:length(tree[i][1])
            push!(res[i],tree[i][1][j])
            mx = max(mx,tree[i][1][j])
        end
    end
    used = zeros(mx)
    for i in 1:length(tree)-1
        used[tree[i][2][1]]=1
    end
    for i in 1:mx
        if used[i]==0
            insert!(res,i,[])
        end
    end
    for i in 1:length(res)-1
        for j in 1:length(res[i])
            used[res[i][j]]=1
            for k in 1:length(v)
                if (res[i][j]==v[k])
                    v[k] = -1
                end
            end
        end
    end
    _root = []
    for i in 1:length(v)
        if (v[i]!=-1)
            push!(_root,v[i])
        end
    end
    root = K[length(K)][1]
    res[root] = _root
    return res
end

struct Tree{T}
    index::T
    sub::Vector{Tree{T}}
    Tree{T}(index,sub) where T =new(index, sub)
end

#Задача 3
function tree_convert(tree::ConnectList{T}, root::T) where T
    _tree = copy(tree)
    list_arr = Array{Tree{Int}}(undef,length(_tree))
    for i in 1:length(_tree)
        list_arr[i] = Tree{Int}(i,[])
    end
    list = list_arr[root]
    q = [root]
    while (!isempty(q))
        cur = first(q)
        deleteat!(q,firstindex(q))
        q = append!(q,_tree[cur])
        for tree in _tree[cur]
            push!(list_arr[cur].sub,list_arr[tree])
        end
    end
    return list
end

#Задача 4
function convert(tree::Tree{T}) where T
    res = []
    root = 1
    for i in 2:tree.index
        push!(res,[])
        root+=1
    end
    q = [tree]
    while (!isempty(q))
        cur = first(q)
        q = append!(q,cur.sub)
        deleteat!(q,firstindex(q))
        for i in cur.sub
            if (cur.index > length(res))
                while (i.index != length(res))
                    push!(res,[])
                end
            end
            push!(res[cur.index],i.index)
        end
    end
    return res
end

#Задача 5
function height(tree::ConnectList{T}, root::T) where T
    h=0
    for i in tree[root]
        h = max(h,height(tree,i))
    end
    return h+1
end

function vernumber(tree::ConnectList{T}) where T
    return length(tree)
end

function leavesnumber(tree::ConnectList{T}, root::T) where T
    if isempty(tree[root])
        return 1
    end
    N=0
    for i in tree[root]
        N += leavesnumber(tree,i)
    end
    return N
end

function maxvalence(tree::NestedVectors)
    mx = 0
    for i in 1:length(tree)
        mx = max(mx,length(tree[i][1]))
    end
    return mx
end

function sumpath_numver(tree::Tree)
    N = 1
    S = 1
    for sub in tree.sub
        s, n = sumpath_numver(sub)
        S += s + 1
        N += n
    end
    return S, N
end

#Задача 6
function alltypes(type)
    for i in subtypes(type)
        println(i)
        alltypes(i)
    end
end

#Задача 7
function find_general(tree::Vector, setver::Set)
    number_visited = 0
    general = 0
    function recurstrace(tree, parent=0)  
        is_mutable_general = false

        for subtree in tree[begin:end-1]
            if number_visited < length(setver)
                recurstrace(subtree, tree[end])
            end
        end
        if tree[end] in setver
            number_visited +=1
            if number_visited == 1
                general = tree[end]
            end                        
        end
        if general==tree[end] 
            is_mutable_general = true
        end
        if is_mutable_general && number_visited < length(setver)
            general = parent
        end
    end
    recurstrace(tree)
    return general
end
