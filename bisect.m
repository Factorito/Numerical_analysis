function bisect(fp, xl, xu, es, maxit)
  %fp = function
  %xl = initial left x
  %xu = initial right x
  %es = least err
  %maxit = iteration
  %f = @(m,) sqrt(g*m/cd)*tanh(sqrt(g*cd/m)*t)-v;
  %if you want to use false position(가위치기 법)
  % replace xr = xu- (fxu*(xl-xu))/(fxl-fxu)


  pxr=0;
  fprintf(" iter      xl      xu      xr      ea(%%) \n ");
  for iter=1:1:maxit
    xr=(xl+xu)/2;
    fxl=fp(xl); fxu=fp(xu);
    %xr = xu- (fxu*(xl-xu))/(fxl-fxu);
    fxr=fp(xr);
    ea=err(xr,pxr);
    fprintf( ' %d | %7.3f  %7.3f  %7.3f   %7.3f\n', iter, xl, xu, xr, ea);
    if fxl*fxr<0
      xu=xr;
      fxu=fxr;
    else
      xl=xr;
      fxl=fxr;
    end
    if ea<es && iter>2 break; end
   pxr=xr;
  endfor

