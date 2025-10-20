%function x = pivoting(A,b)

A = [0 2 3; 4 6 7; 2 -3 6]; b = [8 ;-3; 5];
Aug = [A b];
Aug(2,:) = -Aug(2,1)/Aug(1,1)*Aug(1,:)+Aug(2,:);
Aug(3,:) = -Aug(3,1)/Aug(1,1)*Aug(1,:)+Aug(3,:);


maxcol = A(1,1);

Aug = [A b];

[n,m] = size(A);

for k=1 : n-1
  [M,index] = max(abs(Aug(k:n,k)))
  imsi =Aug(k,:);
  Aug(k,:) = Aug(k-1+index,:);
  Aug(k-1+index,:) = imsi; clear imsi; Aug
  end

for k = 1 : n-1
  for i = k+1 :n
    Aug(i,:) = -Aug(i,k)/Aug(k,k)*Aug(k,:)+Aug(i,:);
  endfor

end

Aug

x = zeros(n,1);
x(n) = Aug(n,n+1)/Aug(n,n);

for i = n-1 :-1: 1
    x(i) = (Aug(i,n+1) - Aug(i,i+1:n)*x(i+1:n))/Aug(i,i);
  end

x
