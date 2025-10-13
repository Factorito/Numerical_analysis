function v = gs(f,xl,xu,maxit,es)

%f = @(x) x^2/10-2*sin(x);
%xl = 0; xu=4;
phi=(1+sqrt(5))/2;
%maxit = 50;
%es = 10^-3;
d=(phi-1)*(xu-xl);

 disp('iter |     xl      xu       xopt       d       err\n');
for i = 1 : maxit
  ds = d;
  d=(phi-1)*(xu-xl);
  x1 = xl+d;
  x2 = xu-d;
  f1 = f(x1);
  f2 = f(x2);

  % if d<es break; end;

  if f1<f2
    xl=x2;
    x=x1;
  else
    xu=x1;
    x=x2;
  end

   ea = (2-phi)*abs((xu-xl)/x)*100;
  if ea<es
    break;
  endif

  fprintf('%d | %f  %f  %f  %f  %f %f',i,xl,xu,x,d,ea);
  fprintf('\n');
end


