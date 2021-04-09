#Задача 1

function find_all_max(a)
    max_i=[1]
    len = length(a)
    for i in 2:len
        if A[i]>A[max_i[end]]
            max_i=[i]
        elseif A[i]==A[max_i[end]]
            push!(max_i, i)
        end
    end
    return max_i    
end

#Задача 2

function sort_puz2!(v::Array)
    right_index_iter = 1
    right_index = 1
    is_sorted = true
    for i in 1:(length(v)-1)
        for j in right_index_iter:(length(v)-1)
            if (v[j]>v[j+1])
                is_sorted = false
                v[j],v[j+1]=v[j+1],v[j]
            elseif (v[j]<=v[j+1] && is_sorted)
                right_index =+1
            end
        end
        right_index_iter=right_index
        is_sorted = true
    end
    return(v)
end

#Задача 3

function sort_shaker!(v::Array)
    left=firstindex(v)
    right=lastindex(v)
    while (left<right)
        for i in right:-1:left+1
            if (v[i-1]>v[i])
                v[i-1],v[i]=v[i],v[i-1]
            end
        end
        left =+1
        for i in left+1:right
            if (v[i-1]>v[i])
                v[i-1],v[i]=v[i],v[i-1]
            end
        end
        right -=1
    end
    return(v)
end

#Задача 4

function shellsort!(a)
    generator=(length(a)÷2^i for i in 1:Int(floor(log2(length(a))))) 
    for i in generator
        for j in firstindex(a):i-1
            insertsort!(@view a[j:i:end]) # - сортировка вставками выделенного (прореженного) подмассива
        end
    end
    return a
end

#Задача 5

function slice(A::Vector{T},p::Vector{Int})::Vector{T} where T
    return A[p]
end

#Задача 6

function permute_!(A::Vector{T},perm::Vector{Int})::Vector{T} where T
    return slice(A,perm);
end

#Задача 7

function delete_at!(A::Vector{T},i::Int)::Vector{T} where T
    new_A=Array{Int}(undef,length(A)-1)
    j=1
    k=1
    while (j<length(A))
        if k!=i
            new_A[j]=A[k]
            j+=1
        end
        k+=1
    end
    return new_A
end

function insert_at!(A::Vector{T},i::Int,value::T)::Vector{T} where T
    new_A=Array{Int}(undef,length(A)+1)
    j=1
    k=1
    while (j<=length(new_A))
        if k==i
            new_A[j]=value
            k-=1
            i=-1
        else
            new_A[j]=A[k]
        end
        k+=1
        j+=1
    end
    return new_A
end

#Задача 9 

reverse(a) = a[end:-1:begin]

#Задача 10

function cyclshift(a::AbstractVector, k::Int) 
    reverse!(a)
    reverse!(@view a[begin:begin+k])
    reverse!(@view a[begin+k+1:end])
end

#Задача 11

function transpose_w_array!(A::Matrix{T})::Matrix{T} where T
    B=Matrix{T}(undef,size(A,2),size(A,1))
    for i in 1:size(A,1)
        for j in 1:size(A,2)
            B[j,i]=A[i,j]
        end
    end
    return B
end

#Задач 12

function transpose!(A::Matrix{T})::Matrix{T} where T
    for i in 1:size(A,1)
        for j in 1:i
            tmp = a[i,j]
            a[i,j] = a[j,i]
            a[j,i] = tmp
        end
    end
    return A
end
