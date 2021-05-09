#Задача 1
function taylor_cos(n,x)
    sum=1
    fact=1
    for i in 1:n
        fact*=i
        if (i%2==0)
            sum+=(((-1)^((i/2)%2))*(x^i))/fact
        end
    end
    return sum
end

#Задача 2
function taylor_cos_(x,ε)
    sum=1
    fact=1
    i=1
    a=1
    while(abs(a)>ε)
        fact*=i
        if (i%2==0)
            a=(((-1)^((i/2)%2))*(x^i))/fact
            sum+=a
        end
    i+=1
    end
    return sum
end

#Задача 3

function build_cos_plots()
    f1(x) = 1-(x^2)/2
    f2(x) = f1(x) + (x^4)/factorial(4)
    f3(x) = f2(x) - (x^6)/factorial(6) + (x^8)/factorial(8)
    f4(x) = f3(x) - (x^10)/factorial(10) + (x^12)/factorial(12) - (x^14)/factorial(14) + (x^16)/factorial(16)
    p=plot(f1) # for i in (f1,f2,f3,f4) не работает
    plot!(f2)
    plot!(f3)
    plot!(f4)
end

#Задача 4
function ln(x,ε)
    x_minus_1=x-1
    sum=x_minus_1
    i=1
    a=0
    while(abs(a)>ε)
        x_minus*=x_minus
        a=(((-1)^(i%2))*x_minus_1)/(i+1)
        sum+=a
        i+=1
    end
    return sum
end

function sqrt_(x,ε)
    an=1
    sum=1
    i=1
    a=0
    while(abs(a)>ε)
        an*=((-1)*(2*i-1)/(2*i))*x
        a=(((-1)^(i%2))*x_minus_1)/(i+1)
        sum+=a
        i+=1
    end
    return sum
end

function xsinx_minusexp(x,ε)
    an1=1
    an2=1
    an3=1
    sum=-2*x^2
    i=2
    a=0
    while(abs(a)>ε)
        an1/=i
        an2/=(2*i-2)(2*i-1)
        an3*=x*x
        a=((-1)^(i%2))*(an1+an2)*an3
        sum+=a
        i+=1
    end
    return sum
end

#Задача 5

function bessel(m,x)
    sum=1/factorial(m)
    i=1
    a=1
    while(abs(a)>ε)
        a*=((-1)/(i*(i+m)))*(x/2)*(x/2)
        sum+=a
        i+=1
    end
    sum*=(x/2)^m
    return sum
end

#Задача 6

function linsolve(A,b)
    for i in length(A):-1:1
        for j in 1:i-1
            b[j]-=(A[j][i]/A[i][i])*b[i]
            A[j][i]=0
        end
    end
    for i in 1:length(A)
        println("x",i," = ",b[i]/A[i][i])
    end
end

#Задача 7

function convert!(Ab)
    for i in 1:length(Ab)
        for j in length(Ab):-1:i+1
            Ab[j,:]-=(Ab[j][i]/Ab[i][i])*Ab[i,:]
        end
    end
    return Ab
end

#Задача 8

function issingular_convert!(Ab)
    for i in 1:length(Ab)
        for j in length(Ab):-1:i+1
            if (Ab[i][i]!=0)
                Ab[j,:]-=(Ab[j][i]/Ab[i][i])*Ab[i,:]
            elseif (A[j][i]!=0)
                temp=Ab[j,:]
                Ab[j,:]=Ab[i,:]
                A[i,:]=A[j,:]
            else
                return true
            end
            #println("R",j," = ",A[j,:])
            if Ab[j,:]==zeros(length(Ab))
                return true
            end
        end
    end
    return false
end

function det_(A)
    B=copy(A)
    if issingular_convert!(B)==true
        return 0
    else
        det=B[1][1]
        for i in 2:length(B)
            det*=B[i][i]
        end
        return det
    end
end

#Задача 9

#Сделаю

#Задача 10

function rang(Ab)
    B=copy(Ab)
    rang = length(B)
    while (det_(B)==0 && rang!=1)
        rang-=1
        B=B[1:rang]
    end
    return rang
end

#Задача 11

#Сделаю

#Задача 12

#Сделаю
