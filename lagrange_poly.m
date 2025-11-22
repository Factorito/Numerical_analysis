function yint = lagrange_poly(x,f,k)

   n = length(x)
   s=0;
   for i = 1:n
     product = f(i);
     for j = 1:n
       if i ~= j
         product = product*(k-x(j))/(x(i)-x(j));
       endif
     endfor
     s = s + product;
   endfor
   yint = s;


