function x=forw(L,b,n)
  x = zeros(n,1);
  x(1)=b(1)/L(1,1);
  for i=2:n
    x(i)=b(i)-L(i,1:i-1) * x(1:i-1);
  endfor



function x=backw(U,d,n)
  x = zeros(n,1);
  x(1)=d(1)/U(1,1);
  for i=n-1:-1:1
    x(i)=(d(i)-U(i,i+1:n) * x(i+1:n))/U(i,i);
  endfor


