#Не нашел нумерацию задач
function sort_puz!(v::Array)
    for i in 1:(length(v)-1)
        for j in 1:(length(v)-1)
            if (v[j]>v[j+1])
                v[j],v[j+1]=v[j+1],v[j]
            end
        end
    end
    return(v)
end

sort_puz(v) = sort_puz!(copy(v))

function sort_bubble(A::Matrix)
    for i in 1:size(A)[2]
        A[:,i]=sort_puz!(A[:,i])
    end
end


function sort_bubble_perm!(a)
    n = length(a)
    indexes = collect(1:n)
    for k in 1:n-1
        istranspose = false
        for i in 1:n-k
            if a[i]>a[i+1]
                a[i],a[i+1]=a[i+1],a[i]
                indexes[i],indexes[i+1]=indexes[i+1],indexes[i]
                istranspose = true
            end
        end
        if istranspose == false
            break
        end
    end
    return indexes
end

function sort_bubble_by_sum(A::Matrix)
    stolb_sum=size(A)[2]
    for i in 1:a[2]
        stolb_sum[i]=sum(A[:,i])
    end
    for i in 1:(a[2]-1)
        for j in 1:(a[2]-1)
            if (stolb_sum[j]>stolb_sum[j+1])
                A[:,j],A[:,j+1]=A[:,j+1],A[:,j]
                stolb_sum[j],stolb_sum[j+1]=stolb_sum[j+1],stolb_sum[j]
            end
        end
    end
end

function sort_bubble_by_zeros(A::Matrix)
    zeros_number=size(A)[2]
    for i in 1:a[2]
        zeros_number[i]=length(findall(iszero, A[:,i])) #кол-во нулей в столбце
    end
    for i in 1:(a[2]-1)
        for j in 1:(a[2]-1)
            if (zeros_number[j]>zeros_number[j+1]) #если нулей больше в первом
                A[:,j],A[:,j+1]=A[:,j+1],A[:,j]
                zeros_number[j],zeros_number[j+1]=zeros_number[j+1],zeros_number[j]
            end
        end
    end
end

function sortkey(a ,key)
    ind = sort_bubble_perm!(key)
    return @view a[ind]

function sort_count(a::Array)
    c=zeros(2^8)
    for i in 1:length(a)
    c[a[i]] += 1
    end
    count = 1
    for i in 1:length(c)
        for j in 1:c[i]
            a[count] = i
            count += 1
        end
    end
end
    
function sort_insert(a::Array)
    for i in 2:length(a)
        key = a[i]
        j = i-1
        while ((j>0)&&(a[j]>key)) 
            a[j+1] = a[j]
            j -=1
        end
        a[j+1]=key
    end
end

function binary_search(num::Int,a::Array)
    low = 1
    high = length(a)
    while (low<=high)
        mid = div(low+high,2)
        if (num < a[mid])
            high = mid - 1
        elseif (num > a[mid])
            low = mid + 1
        else
            return mid
        end
    end
    return -1
end
