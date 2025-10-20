function x=backw(U,d,n)
  x = zeros(n,1);
  x(1)=d(1)/U(1,1);
  for i=n-1:-1:1
    x(i)=(d(i)-U(i,i+1:n) * x(i+1:n))/U(i,i);
  endfor


