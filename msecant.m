function v = msecant(f,x0,es,dx0,maxit)


fprintf("iteration |  x1  ,   rerr\n");

for i= 1:maxit

imsi = x0+dx0;

x1 = x0-f(x0)*dx0/(f(imsi)-f(x0));
ea = err(x0,x1);
fprintf("%d ,   %7.3f ,   %7.5f\n",i,x1,ea);
x0 = x1;

if ea<es break; end

end




