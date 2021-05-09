#Задача 1
function pow(a, n::Integer)
    k, t, p = n, 1, a
    while k>0
        if (k%2 == 0)
            k÷=2
            p*=p
        else
            k-=1
            t*=p
        end   
    end
return t
end

#Задача 2
function fibonacci(n::Integer)
    a,b,c=1,1,1
    rc,d,rd = 0,0,1
    while (n>0)
        if (n%2!=0)
            tc = rc
            rc = rc*a + rd*c
            rd = tc*b + rd*d
        end
        ta,tb,tc=a,b,c
        a = a*a  + b*c
        b = ta*b + b*d
        c = c*ta + d*c
        d = tc*tb+ d*d
        n >>= 1
    end
    return rc
end

#Задача 3
function log(a::Real,x::Real,ε::Real)
    z, t, y = x, 1, 0
while (z>a || z<1/a || t>ε)
    if (z>a)
        z/=a
        y+=t
    elseif (z<1/a)
        z*=a
        y-=t
    else
        t/=2
        z*=z
    end
end
return y
end

#Задача 4
function isprime(n::Int)::Bool
    d=2
    while (d*d<=n)
        if (n%d==0)
            return false
        end
        d+=1
    end
    return true
end

#Задача 5
function eratosphen(n::Integer)
    ser=fill(true,n)
    ser[1]=false
    k=2
    while k<n || k !== nothing
        ser[2k:k:end] .= false # но лучше: numser[k^2:k:end] .= false
        k=findnext(ser, k+1)
    end
    return findall(ser)
end

#Задача 6
function factor(n)
    if (isprime(n))
        return n,1
    end
    v_d = []
    v_k = []
    d = 2
    n_copy=n
    k = 0
    while (d*d<=n && n_copy>1)
        if (isprime(d))
            if (n_copy%d == 0)
                push!(v_d,d)
                while (n_copy%d == 0)
                    n_copy/=d
                    k+=1
                end
                push!(v_k,k)
                k=0
            end 
        end
        d+=1
    end
    if (n_copy!=1)
        push!(v_d,Int(n_copy))
        push!(v_k,1)
    end
    return v_d,v_k
end

#Задача 7
function euler_function(n)
    if (isprime(n))
        return n-1
    else
        a,b=factor(n)
        res=1
        for i in 1:length(a)
            if (b[i]==1)
                a[i]-=1
            else
                a[i] = a[i]^b[i] - a[i]^(b[i]-1)
            end
            res*=a[i]
        end
        return res
    end
end
        
#Задача 8
function gcdex(m::Int,n::Int)
    a, b = m, n
u_a, v_a = 1, 0
u_b, v_b = 0, 1
while b != 0
    k = a÷b
    a, b = b, a % b 
    u, v = u_a, v_a
    u_a, v_a = u_b, u_a
    u_b, v_b = u-k*u_b, v-k*v_b
end
if u_a<0
    u_a+=n
end
return u_a
end

#Задача 9
function inv(m::Integer,n::Integer)
    if (gcd(m,n)>1)
        return nothing
    else
        return gcdex(m,n)
    end
end

#Задача 10
function zerodivisors(n::Integer)
    v = [1]
    for i in 2:n
        if (gcd(n,i)==1)
                push!(v,i)
        end
    end
    return v
end

#Задача 11
function allnilpotents(n::Integer)
    nil = []
    v_d,nothing=factor(n)
    mult = 1
    for i in 1:length(v_d)
        mult *=v_d[i]
    end
    count_nil = Int(n/mult)
    for i in 1:count_nil-1
        push!(nil,mult*i)
    end
    return nil
end

#Задача 12
function order(a,p)
    phi = p-1
    res = 0
    for i in 1:(p-1)
        if (phi%i==0 && (a^i)%p==1)
            res = i
            break
        end
    end
    return res
end

#Задача 13
function bisect(f::Function, a, b, ε)
    y_a=f(a)
    while b-a > ε
        x_m = (a+b)/2
        y_m=f(x_m)
        if y_m==0
            return x_m
        end
        if y_m*y_a > 0 
            a=x_m
        else
            b=x_m
        end
    end
    return (a+b)/2
end
