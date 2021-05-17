abstract type AbstractCombinObject
    #value::Vector{Int} - это поле предполагается у всех конкретных типов, наследующих от данного типа
end

Base.iterate(obj::AbstractCombinObject) = (get(obj), nothing)
Base.iterate(obj::AbstractCombinObject, state) = 
    if next!(obj) == false
        nothing
    else
        (get(obj), nothing)
    end

Base.get(obj::AbstractCombinObject) = obj.value

#Задача 1
#1)
struct RepPlacement{N,K} <: AbstractCombinObject
    value::Vector{Int}
    set::Vector
end

RepPlacement{K}(n::Integer) where K = RepPlacement{K}(ones(Int, K),collect(1:n))
RepPlacement{K}(set::Set) where K = RepPlacement{K}(ones(Int, K),collect(set))

Base.get(placement::RepPlacement) = placement.set(placement.value)

function next!(placement::RepPlacement)
    c = placement.value
    n = length(placement.set)
    i = findlast(item->item < n, c)
    if isnothing(i)
        return false
    end
    c[i] += 1
    c[i+1:end] .= 1
    return true
end

#2)
struct Replacement{N,K} <: AbstractCombinObject
    value::Vector{Int}
    count::Vector
end

Replacement{N,K}() where {N,K} = Replacement{N,K}(ones(Int, K),[0])

function next!(placement::Replacement{N,K}) where {N,K}
    c = get(placement)
    placement.count[1] += 1
    c[begin:end] = digits(placement.count[1],N,K)
    i = findlast(item->item < N, c)
    if isnothing(i)
        return false
    end
    return true
end

function digits(num,n,K)
    res = []
    for i in 1:K
        push!(res,num%n+1)
        num ÷= n
        for j in i:-1:2
            res[j],res[j-1]=res[j-1],res[j]
        end
    end
    return convert(Array{Int,1},res)
end

#Задача 2
struct Permute{N} <: AbstractCombinObject
    value:Vector{Int}
end

Permute{N}() where N = Permute{N}(collect(1:N))

function next!(w::Permute{N}) where N
    p=get(w)
    k=0
    for i in N-1:-1:1
        if p[i] < p[i+1]
            k=i
            break
        end
    end
    if k==0
        return false
    end
    i=k+1
    while i < N && p[i+1] > p[k]
        i+=1
    end
    p[k], p[i] = p[i], p[k]
    reverse!(@view p[k+1:end])
    return true
end

#Задача 3
struct SetIndicator{N} <: AbstractCombinObject
    value::Vector{Bool}
end

SetIndicator{N}() where N = SetIndicator{N}(zeros(Bool, N))

function next!(indicator::IndicatorSet)
    i = findlast(item->item==0, indicator.value)
    if isnothing(i)
        return false
    end
    indicator.value[i] = 1
    indicator.value[i+1:end] .= 0
    return true 
end

#Задача 4
struct KSetIndicator{N,K} <: AbstractCombinObject
    value::Vector{Bool}
end

KSetIndicator{N, K}() where {N, K} = SetIndicator{N,K}([zeros(Bool, N-K); ones(Bool, K)])

function next!(indicator::KSetIndicator)
    i = lastindex(indicator.value)
    while indicator.value[i]==0
        i-=1
    end
    m=0; 
    while i >= firstindex(indicator.indicator) && indicator.indicator[i]==1 
        m+=1
        i-=1
    end 
    if i < firstindex(indicator.value)
        return false
    end
    indicator.value[i]=1
    indicator.value[i+1:i+m-1] .= 0
    indicator.value[i+m:end] .= 1
    return true
end

#Задача 5
struct NumSplit{N} <: AbstractCombinObject
    value::Vector{Int}
    num_terms::Int
end

NumSplit{N}() where N = NumSplit{N}(collect(1:N), N)

function next!(split::NumSplit) 
    if split.num_terms == 1
        false
    end
    s=split.value
    k=split.num_terms
    i=k-1
    while i > 1 && s[i-1]==s[i]
        i -= 1
    end
    s[i] += 1
    r=sum(@view s[i+1:k])
    k=i+r-1
    s[i+1:k] .= 1
    split.num_terms = k
    return true
end