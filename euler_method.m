v= -20;
g = 9.81;
c1 = 0.25;
c2 = 1.5;
m = 80;

for t= 1 : 20
  if t < 10
    v = v + g - c1/m*v^2;
  else
    v = v + g - c2/m*v^2;
  end
  fprintf('t = %d v = %d\n',t,v)
end
