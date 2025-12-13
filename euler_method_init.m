function [T, Y] = euler_method(f, t0, y0, h, N)
% EULER_METHOD
% 1계 상미분 방정식 dy/dt = f(t, y)를 오일러 방법으로 풉니다.
%
% 입력:
% f: 함수 핸들, f(t, y) 형태
% t0: 초기 t 값
% y0: 초기 y 값 (y(t0))
% h: 단계 크기 (step size)
% N: 반복 횟수 (N번의 스텝)
%
% 출력:
% T: t 값 벡터 (t0, t1, ..., tN)
% Y: y 값 벡터 (y0, y1, ..., yN)

% 벡터 크기 설정
T = zeros(N + 1, 1);
Y = zeros(N + 1, 1);

% 초기값 설정
T(1) = t0;
Y(1) = y0;
t = t0;
y = y0;

% 반복 계산
for i = 1:N
    % 오일러 공식 적용
    y = y + f(t, y) * h;
    t = t + h;
    
    % 결과 저장
    T(i + 1) = t;
    Y(i + 1) = y;
end
end
