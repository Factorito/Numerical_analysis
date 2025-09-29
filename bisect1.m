function bisect1(fp, xl, xu, es, maxit)
  t=4; v=36; cd=0.25; g=9.81;
  fp = @(m) sqrt(g*m/cd)*tanh(sqrt(g*cd/m)*t)-v;
  a=fp(xl); b=fp(xu);

  xro=0;
  fprintf(" iter xl xu xr ea(%%) \n ");
  for iter=1:1:100
    xr=xu-b*(xl-xu)/(a-b);
    c=fp(xr);
    ea=err(xro, xr);
    fprintf( ' %d | %7.3f %7.3f %7.3f %7.3f\n', iter, xl, xu, xr, ea);
    if a*c<0
      xu=xr;
      b=c;
    else
      xl=xr;
      a=c;
    end
    if ea<es break; end
   xro=xr;
  endfor

