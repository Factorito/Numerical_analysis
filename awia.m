function v = awia(P, i, n)
  fprintf("P = $%.2f ----- n = %d years -----\n", P, n);
  for j = 1:n
    F = P * (1+i)^j;
    fprintf("Year %d: %f\n", j, F);
  endfor
  v = F;
end

