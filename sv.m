function [mean,stdev] = sv(x)

  n = length(x);
  mean = sum(x)/n;
  stdev= sqrt(sum((x-mean).^2/(n-1)));





  end
