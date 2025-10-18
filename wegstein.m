function v = wegstein(g,x0,x1,es,maxit)

fprintf("iteration ,  x1  ,   rerr\n");
for i= 1:maxit
x2 = (x1*g(x0)-x0*g(x1))/(x1-x0-g(x1)+g(x0));
ea = err(x2,x1);

fprintf("%d ,   %7.3f ,   %7.3f\n",i,x1,ea);
x0 = x1;
x1 = x2;
if ea<es break; end
end





