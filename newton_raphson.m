function v = newton_raphson(f,df,x0,es,maxit)

x1 = x0-f(x0)/df(x0);

fprintf("iteration |  x1  ,   rerr\n");
for i= 1:maxit
ea = err(x0,x1);

fprintf("%d ,   %7.3f ,   %7.3f\n",i,x1,ea);
x0 = x1;
if ea<es break; end
end




