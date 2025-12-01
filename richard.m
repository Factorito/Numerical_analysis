%f= @(x) 0.2+25*x-200*x^2+ 675*x^3 - 900*x^4 + 400*x^5
f = @(x) 1/x;
a = 1; b = 5; t_val = 0;


h=b-a
T0 = (b-a)*(f(a)+f(b))/2
err(T0,t_val)

h=h/2
T1 = 1/2*T0+h*f(a+h)
err(T1,t_val)


l1 = 4/3*T1-1/3*T0

h = h/2
T2 = 1/2*T1+h*(f(a+h)+f(a+3*h))
err(T2,t_val)


l2 = 4/3*T2-1/3*T1
err(l2,t_val)


l3 = 16/15*l2-1/15*l1

err(l3,t_val)


printf('h O(h^2)    O(h^4)  O(h^6)');
printf('\n');
printf('%d   %d         %d        %d  ',4,T0,l1,l3);
printf('\n');
printf('%d   %d         %d            ',2,T1,l2);
printf('\n');
printf('%d   %d                       ',1,2);
