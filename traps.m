f = @(x) 0.2+25*x-200*x^2+ 675*x^3 - 900*x^4 + 400*x^5
a = 0;  b = 0.8; t_val  = 1.640533

%v = (b-a)*(f(a)+f(b))/2
%err(t_val,v)  //1차

%m = (a+b)/2; n=2;
%v = (b-a)*(f(a)+2*f(m)+f(b))/(2*n)
%err(v,t_val) //합성


%x1 = linspace(0,10,5)
%n = length(x1), x=x1(2:n)
%h=(b-a)/2
%v = 1/3*h*(f(a)+4*f(x(1))+f(b))
%err(v,t_val) //simposon 1/3

%h = (b-a)/4
%x1 = linspace(a,b,5) , n=length(x1), x = x1(2:n)
%v = 1/3*h*(f(a)+4*f(x(1))+4*f(x(3))+2*f(x(2))+f(b))
%err(v,t_val) //합성 simposon 3/8

%h = (b-a)/3
%x1 = linspace(a,b,4); n=length(x1); x=x1(2:n)
%v = 3/8*h*(f(a)+3*f(x(1))+3*f(x(2))+f(b))
%err(v,t_val) //합성 simposon 3/8

%h = (b-a)/5
%x1 = linspace(a,b,6),n=length(x1), x=x1(2:n)
%v1 = 1/3*h*(f(a)+4*f(x(1))+f(x(2)))
%v2 = 3/8*h*(f(x(2))+3*f(x(3))+3*f(x(4))+f(b))
%v=v1+v2
%err(v,t_val) //simposon 1/3+3/8






