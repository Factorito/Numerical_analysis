function v = relerr(a,b)
  %a = primitive value
  %b = calculate value
  %return value is percentage(%)
  c = abs(a-b);
  v = c/a *100;

