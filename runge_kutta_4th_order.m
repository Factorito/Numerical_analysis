function [T, Y] = runge_kutta_4th_order(f, t0, y0, h, N)
% RUNGE_KUTTA_4TH_ORDER
% 1계 상미분 방정식 dy/dt = f(t, y)를 4차 룽게-쿠타 방법으로 풉니다.
%
% 입력:
% f: 함수 핸들, f(t, y) 형태 (예: @(t,y) 4*exp(0.8*t)-0.5*y)
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

% 현재 t와 y에 초기값 할당
t_current = t0;
y_current = y0;

% N번 반복 계산
for i = 1:N
    % -----------------------------------------------------
    % 1. 4차 룽게-쿠타 계수 (k1, k2, k3, k4) 계산
    % -----------------------------------------------------
    
    % k1: 현재 t와 y에서의 기울기 (오일러 방법과 동일)
    k1 = f(t_current, y_current);

    % k2: t+h/2 지점에서의 기울기 (k1로 예측한 y 사용)
    t_half = t_current + h / 2;
    y_k2   = y_current + h / 2 * k1;
    k2 = f(t_half, y_k2);

    % k3: t+h/2 지점에서의 기울기 (k2로 예측한 y 사용)
    y_k3   = y_current + h / 2 * k2;
    k3 = f(t_half, y_k3); % t는 k2 계산 시 사용한 t_half 재사용

    % k4: t+h 지점에서의 기울기 (k3로 예측한 y 사용)
    t_next = t_current + h;
    y_k4   = y_current + h * k3;
    k4 = f(t_next, y_k4);

    % -----------------------------------------------------
    % 2. 기울기의 가중 평균 (phi) 계산
    % -----------------------------------------------------
    
    % phi = 1/6 * (k1 + 2*k2 + 2*k3 + k4)
    phi = (k1 + 2*k2 + 2*k3 + k4) / 6;

    % -----------------------------------------------------
    % 3. 다음 스텝의 y 값 계산 및 업데이트
    % -----------------------------------------------------
    
    % y_next = y_current + phi * h
    y_next = y_current + phi * h;
    
    % t_next = t_current + h (이미 k4 계산 시 t_next로 계산됨)
    
    % 결과 저장
    T(i + 1) = t_next;
    Y(i + 1) = y_next;
    
    % 다음 반복을 위한 현재 값 업데이트
    t_current = t_next;
    y_current = y_next;
end
end
