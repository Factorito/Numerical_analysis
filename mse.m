%function mse =


x = 10 : 10 : 80;
x=x'
y = [25, 70, 380,550,610,1220,830,1420]'

plot(x,y,'o');

A(1,1) = length(x);
A(1,2) = sum(x);
A(2,1) = sum(x);
A(2,2) = sum(x.^2);
b(1) = sum(y);
b(2) = sum(x.*y);
b=b';
inv(A).*b

hold on

p = [19.4702 -234.2857];
z = 10:80;
zy = polyval(p,z);
plot(z,zy);



