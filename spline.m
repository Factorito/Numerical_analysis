
x1= 5;
x = [3.0 , 4.5, 7.0, 9.0];
f = [2.5, 1.0, 2.5, 0.5];


n = length(x)/2;
while n>1 && n<=length(x)
  if x1<=x(n) && x1>=x(n-1)
    break

  elseif x1>x(n)
    n = n+1 ;

  else
  n = n-1;
end

end


fs = @(v) f(n-1)+ ((f(n)-f(n-1))/(x(n)-x(n-1)))*(v-x(n-1));

rf = fs(x1)
