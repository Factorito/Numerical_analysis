% 주어진 데이터
xi = linspace(0, 2*pi, 8);
f  = sin(xi).*sin(xi);

n = length(xi);

% 1. h_k (구간 길이)와 b_k (차분) 계산
h = zeros(n-1, 1); % h(k) = xi(k+1) - xi(k)
b_diff = zeros(n-1, 1); % b_diff(k) = f(k+1) - f(k)

for k = 1 : n-1
    h(k) = xi(k+1) - xi(k);
    b_diff(k) = f(k+1) - f(k);
end

% 2. b1_k
b1 = zeros(n, 1); % b1은 n x 1
for k = 2 : n-1 % k=2부터 n-1까지 (2, 3, 4, 5)
    % C_k에 대한 연립방정식의 우변 b1_k
    b1(k) = 3 * (b_diff(k)/h(k) - b_diff(k-1)/h(k-1));
end

% 자연 스플라인 경계 조건: c_1 = 0, c_n = 0
% A*c = b1에서 첫 번째와 마지막 행이 c_1=0과 c_n=0을 의미
b1(1) = 0;   % A(1,1) * c(1) = 0
b1(n) = 0;   % A(n,n) * c(n) = 0

% 3. 계수 행렬 A (n x n) 구성
A = zeros(n, n);

% 경계 조건 (c_1 = 0, c_n = 0)
A(1, 1) = 1;      % 1행: c_1 = 0
A(n, n) = 1;      % n행: c_n = 0

% 내부 점 (k = 2 to n-1)
for k = 2 : n-1
    A(k, k-1) = h(k-1);
    A(k, k)   = 2 * (h(k-1) + h(k));
    A(k, k+1) = h(k);
end

% A, b1, c 계산
A
b1
c = A \ b1

d = zeros(n-1, 1);
for k = 1 : n-1
    d(k) = (c(k+1) - c(k)) / (3 * h(k));
end

d

% 5. b_k 계수 계산
% b(k)는 n-1개 (k=1 to n-1)
b = zeros(n-1, 1);
for k = 1:n-1
    b(k) = (f(k+1)-f(k))/h(k) - h(k)/3 * (2*c(k) + c(k+1));
end

b

k_val = 2;
s2 = @(x) f(k_val) + b(k_val)*(x-xi(k_val)) + c(k_val)*(x-xi(k_val))^2 + d(k_val)*(x-xi(k_val))^3

s2(2.25) %target argument



x_plot = [];
y_spline = [];

for k = 1 : n-1
    % 구간 [xi(k), xi(k+1)]에 대해 촘촘한 x 벡터 생성
    x_segment = linspace(xi(k), xi(k+1), 100)';

    % delta_x = x - x_k
    delta_x = x_segment - xi(k);

    % S_k(x) = f_k + b_k*(x-x_k) + c_k*(x-x_k)^2 + d_k*(x-x_k)^3
    % MATLAB 인덱스: f(k), b(k), c(k), d(k) 사용
    y_segment = f(k) + b(k) .* delta_x + c(k) .* (delta_x.^2) + d(k) .* (delta_x.^3);

    % 전체 플롯 데이터에 추가
    x_plot = [x_plot; x_segment];
    y_spline = [y_spline; y_segment];
end

% 4. 그래프 출력
figure; % 새로운 그래프 창 열기
hold on; % 기존 플롯을 유지하며 새로운 플롯 추가

% 3차 스플라인 곡선 (파란색 실선)
plot(x_plot, y_spline, 'b-', 'LineWidth', 2, 'DisplayName', 'Cubic Spline S(x)');

% 원본 데이터 포인트 (빨간색 마커)
scatter(xi, f, 'r', 'filled', 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k', 'SizeData', 80, 'DisplayName', 'Data Points (xi, fi)');

% 축 및 제목 설정
title('Cubic Spline Interpolation with Natural Boundary Conditions');
xlabel('x');
ylabel('f(x)');
legend('Location', 'best');
grid on;


hold off;


