f= @(t,y) 4*exp(0.8*t)-0.5*y;
t0 = 0; y0=2; h=1;
for i = 1:2
k1 = f(t0,y0);


t=t0+h/2; y=y0+h/2*k1;
k2 = f(t,y);

y=y0+h/2*k2;
k3=f(t,y);

t= t0+h; y=y0+h*k3
k4=f(t,y);


phi = 1/6*(k1+2*k2+2*k3+k4)

y = y0+phi*h
t0 = t0+1;
end

y

