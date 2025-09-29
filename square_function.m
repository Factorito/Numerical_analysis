x = -1 : 0.05 : 1;

T1 = x;
T2 = 2*x.^2-1;
T3 = 4*x.^3-3*x;
T4 = 8*x.^4-8*x.^2+1;



plot(x,T1);
hold on;
xlabel('x');
ylabel('y');

title('homework 2');

grid on
plot(x,T2);
plot(x,T3);
plot(x,T4);

legend('x','2x^2-1','4x^3-3x','8x^4-8x^2+1');


% T1 = x
roots_T1 = roots([1, 0]);
plot(roots_T1, 0, 'ko', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'T1 Roots');
fprintf('T1 = x 의 근: %f\n', roots_T1);

% T2 = 2x^2 - 1
roots_T2 = roots([2, 0, -1]);
plot(roots_T2, zeros(size(roots_T2)), 'ro', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'T2 Roots');
fprintf('T2 = 2x^2 - 1 의 근:\n');
disp(roots_T2);

% T3 = 4x^3 - 3x
roots_T3 = roots([4, 0, -3, 0]);
plot(roots_T3, zeros(size(roots_T3)), 'go', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'T3 Roots');
fprintf('T3 = 4x^3 - 3x 의 근:\n');
disp(roots_T3);

% T4 = 8x^4 - 8x^2 + 1
roots_T4 = roots([8, 0, -8, 0, 1]);
plot(roots_T4, zeros(size(roots_T4)), 'bo', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'T4 Roots');
fprintf('T4 = 8x^4 - 8x^2 + 1 의 근:\n');
disp(roots_T4);
