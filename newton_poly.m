function yint = newton_poly(x,f,k)

  %i j = range
  % k = target parameter
  n = length(x);
  b = zeros(n,n);
  b(:,1) = f(:);
  for j = 2:n
    for i = 1:n-j+1
      b(i,j) = (b(i+1,j-1)-b(i,j-1))/(x(i+j-1)-x(i));
    endfor
  endfor
  xt = 1;
  yint = b(1,1);
  for j = 1:n-1
    xt = xt*(k-x(j));
    yint = yint+b(1,j+1)*xt;
  endfor

