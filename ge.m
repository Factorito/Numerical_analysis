function x = ge(A,b)

%A = [3 -0.1 -0.2; 0.1 7 -0.3; 0.3 -0.2 10]; b = [7.85; -19.3; 71.4];
%Aug = [A b];
%Aug(2,:) = -Aug(2,1)/Aug(1,1)*Aug(1,:)+Aug(2,:);
%Aug(3,:) = -Aug(3,1)/Aug(1,1)*Aug(1,:)+Aug(3,:);




Aug = [A b];

[n,m] = size(A);

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
