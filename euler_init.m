f = @(t,y) 4*exp(0.8*t)-0.5*y;
h=1; t=0; y=2
for k = 1:4
  y= y+f(t,y)*h
  t = t+h;
end
%euler

h=1; t=0; y=2

for k = 1:4
  y0 = f(t,y);
  y10= y+y0*h;
  t = t+h;
  y= y + (y0+f(t,y10))/2*h


end



