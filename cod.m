function r = cod(x,y,n)
  %coefficient of determination
  r = (n*sum(x.*y)-sum(x)*sum(y))/(sqrt(n*sum(x.^2)-sum(x).^2)*sqrt(n*sum(y.^2)-sum(y).^2))

