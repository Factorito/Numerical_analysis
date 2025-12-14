function [y_target, A, c] = cubic_spline(xi, f, x_target)
% NATURAL_CUBIC_SPLINE: 자연 경계 조건을 사용하여 3차 스플라인 보간을 수행합니다.
%
% 입력:
%   xi: 데이터 포인트의 x-좌표 벡터 (1 x n 또는 n x 1)
%   f: 데이터 포인트의 y-좌표 벡터 (1 x n 또는 n x 1), f(i) = f(xi(i))
%   x_target: 보간 다항식을 평가할 목표 x-값 (스칼라 또는 벡터)
%
% 출력:
%   y_target: x_target에서의 보간된 y-값
%   A: 연립방정식 A*c = b1의 계수 행렬 (삼중 대각 행렬)
%   c: 2차 미분 계수 벡터 c (Spline의 계수)

% 1. 입력 데이터 정렬 및 크기 확인
xi = xi(:); % 열 벡터로 변환
f = f(:);
n = length(xi);

if n < 2
    error('데이터 포인트는 최소한 2개 이상이어야 합니다.');
end

% 2. h_k (구간 길이)와 b_diff (차분) 계산
h = diff(xi); % h(k) = xi(k+1) - xi(k)
b_diff = diff(f); % b_diff(k) = f(k+1) - f(k)

% 3. 삼중 대각 행렬 A와 우변 벡터 b1 구성
% 3차 스플라인의 핵심은 각 구간의 2차 미분 계수 c를 찾는 것입니다.
% A*c = b1
A = zeros(n, n);
b1 = zeros(n, 1);

% 자연 스플라인 경계 조건: c_1 = 0, c_n = 0
A(1, 1) = 1;      % 1행: c_1 = 0
b1(1) = 0;
A(n, n) = 1;      % n행: c_n = 0
b1(n) = 0;

% 내부 점 (k = 2 to n-1)에 대한 연립방정식 구성
% 공식: h(k-1)*c(k-1) + 2*(h(k-1)+h(k))*c(k) + h(k)*c(k+1) = 3 * ( (f(k+1)-f(k))/h(k) - (f(k)-f(k-1))/h(k-1) )
% 여기서 인덱스 k는 2부터 n-1까지 변합니다. (MATLAB 인덱스)
for k = 2 : n-1
    A(k, k-1) = h(k-1);
    A(k, k)   = 2 * (h(k-1) + h(k));
    A(k, k+1) = h(k);
    
    % 우변 b1_k 계산 (3 * [f'(k+) - f'(k-)] )
    b1(k) = 3 * (b_diff(k)/h(k) - b_diff(k-1)/h(k-1));
end

% 4. 2차 미분 계수 c 계산 (A*c = b1)
c = A \ b1; % A*c = b1 연립방정식을 풉니다.

% 5. 나머지 계수 d_k와 b_k 계산
% c는 n개 (c(1) to c(n)), d와 b는 n-1개 (d(1) to d(n-1))
d = zeros(n-1, 1);
b = zeros(n-1, 1);

for k = 1 : n-1
    % d_k = (c(k+1) - c(k)) / (3 * h(k))
    d(k) = (c(k+1) - c(k)) / (3 * h(k));
    
    % b_k = (f(k+1)-f(k))/h(k) - h(k)/3 * (2*c(k) + c(k+1))
    b(k) = b_diff(k)/h(k) - h(k)/3 * (2*c(k) + c(k+1));
end

% 6. 목표 x_target 값에서의 보간 값 계산
x_target = x_target(:);
y_target = zeros(length(x_target), 1);

% 각 목표 x_target에 대해 해당하는 구간 S_k를 찾아 보간합니다.
for m = 1:length(x_target)
    x = x_target(m);
    
    % 해당하는 구간 k 찾기: x_k <= x < x_{k+1}
    % find(xi <= x)는 x보다 작거나 같은 xi의 인덱스를 반환합니다.
    % max(find(xi <= x))는 그 중 가장 큰 인덱스 k를 찾습니다.
    k_indices = find(xi <= x);
    if isempty(k_indices)
        % x가 xi(1)보다 작을 경우 (첫 번째 구간의 왼쪽)
        k = 1;
    else
        k = max(k_indices);
    end
    
    % 마지막 점 xi(n)에 도달한 경우 (마지막 구간의 오른쪽 경계)
    if k == n
        k = n-1;
    end
    
    % S_k(x) = f_k + b_k*(x-x_k) + c_k*(x-x_k)^2 + d_k*(x-x_k)^3
    delta_x = x - xi(k);
    
    % f(k)는 데이터 값, b(k), c(k), d(k)는 계수 (k=1 to n-1)
    y_target(m) = f(k) + b(k) * delta_x + c(k) * (delta_x^2) + d(k) * (delta_x^3);
end

end
