t0 = -5:0.1:0;
f0 = zeros(size(t0));

t1 = 0:0.1:8;
f1 = 10*t1.^2 - 5*t1;

t2 = 8:0.1:16;
f2 = 624 - 3*t2;

t3 = 16:0.1:26;
f3 = 36*t3 + 12*(t3-16).^2;

t4 = 26:0.1:50;
f4 = 2136*exp(-0.1*(t4-26));

plot(t0,f0,'k','LineWidth',2); hold on;
plot(t1,f1,'b','LineWidth',2);
plot(t2,f2,'r','LineWidth',2);
plot(t3,f3,'g','LineWidth',2);
plot(t4,f4,'m','LineWidth',2);

grid on;
xlabel('t');
ylabel('f(t)');

