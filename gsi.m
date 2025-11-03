


A = [3 -0.1 -0.2; 0.1 7 -0.3; 0.3 -0.2 10]; b = [7.85; -19.3; 71.4];
[m,n] = size(A);
M = tril(A);
N = M-A;
xi = zeros(m,1);
xn = zeros(m,1);

maxit = 5;

for i = 1 : maxit
xn(1) = (b(1)-sum(A(1,2:n)*xi(2:n)))/A(1,1)
xn(2) = (b(2)-sum(A(2,3:n)*xi(3:n)-A(2,1:1)*xn(1)))/A(2,2)
xn(3) = (b(3)-sum(A(3,1:2)*xn(1:2)))/A(3,3)

es = abs(xn-xi)./abs(xn).*100
xi=xn

end

