%전향차분, 후향차분, 중심차분
%h = step
%f = target function , parameter must be @(x)
%n = interval (array)
function v = num_der(h,f,n)
  format long
  f1 = (f(n+h)-f(n))/h;
  f2 = (f(n)+f(n-h))/h;
  f3 = (f(n+h)-f(n-h))/2*h;
  plot(n,f1,'r-o','DisplayName','Forward'); hold on;
  plot(n,f2,'b-s','DisplayName','Backward');
  plot(n,f3,'g-^','DisplayName','Central');
  grid on;
  xlabel('x');
  ylabel('Derivative approximation');
  legend show;
