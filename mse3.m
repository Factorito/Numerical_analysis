% 최소 제곱법을 이용한 2차 다항식 피팅

x1 = [0,2,1.5,1,4,7]';
x2 = [0,1,2,3,6,2]';
y = [5,10,9,0,3,27]';

n = length(x);

% 2차 다항식 피팅을 위한 최소 제곱법 행렬 A (X'X) 정의
% A = [ n, sum(x), sum(x^2);
%       sum(x), sum(x^2), sum(x^3);
%       sum(x^2), sum(x^3), sum(x^4) ];
A = [ n,       sum(x1),    sum(x2);
      sum(x1),  sum(x1.^2), sum(x1.*x2);
      sum(x2), sum(x1.*x2), sum(x2.^2) ];

% 벡터 c (X'y) 정의
% c = [ sum(y); sum(x.*y); sum(x^2.*y) ];
c = [ sum(y); sum(y.*x1); sum(y.*x2)];

% 계수 벡터 b = [b1 (상수항); b2 (x항); b3 (x^2항)] 계산
% 역행렬을 사용하는 것보다 행렬 나눗셈(백슬래시)이 더 안정적입니다.
b = A \ c; % b = inv(A) * c;와 동일한 행렬 곱셈 수행

% polyval 함수 사용을 위해 계수 순서를 [x^2항, x항, 상수항]으로 뒤집기
b_polyval = flipud(b);

% 피팅 곡선을 그릴 x 범위 (원래 데이터 범위 근처)
z = min(x):0.1:max(x);

% 피팅된 다항식 값 계산
zy = polyval(b_polyval, z);


% 계산된 계수 출력 (b1 + b2*x(1) + b3*x(2)^2)
fprintf('Fit coefficients (b1, b2, b3):\n');
disp(b');
fprintf('The fitted polynomial is: y = %f + %f*x + %f*x^2\n', b(1), b(2), b(3));

