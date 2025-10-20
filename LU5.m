function x = LU5(A,b)

A = [3 -0.1 -0.2; 0.1 7 -0.3; 0.3 -0.2 10]; b = [7.85; -19.3; 71.4];
Aug = [A b];
Aug(2,:) = -Aug(2,1)/Aug(1,1)*Aug(1,:)+Aug(2,:);
Aug(3,:) = -Aug(3,1)/Aug(1,1)*Aug(1,:)+Aug(3,:);




Aug = A;

[n,m] = size(A);
L = eye(n);


for k = 1 : n-1
  for i = k+1 :n
    L(i,k) = Aug(i,k)/Aug(k,k);
    Aug(i,:) = -L(i,k)/Aug(k,k)*Aug(k,:)+Aug(i,:);
  endfor

end

L
U= Aug
d = forw(L,b,n)
x=backw(U,d,n)

x

