function v= fpi(g,x0,es,maxit)


fprintf("iteration ,  x1  ,   rerr\n");
for i= 1:maxit
x1 = g(x0);
ea = err(x0,x1);

fprintf("%7.3f , %7.3f , %7.3f\n",i,x1,ea);
x0 = x1;

if ea<es break; end
end




