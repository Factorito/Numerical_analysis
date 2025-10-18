function v = err(a,b)
  %a = primitive value
  %b = calculate value
  %return value is percentage(%)
  c = abs(a-b);
  v = abs(c/a) *100;

