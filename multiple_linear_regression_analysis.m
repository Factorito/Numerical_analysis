function [grad, R2, syx, mse_val] = multiple_linear_regression_analysis(X_data, Y_data)
% MULTIPLE_LINEAR_REGRESSION_ANALYSIS
% 다중 선형 회귀 (Multiple Linear Regression) 분석을 수행하고
% 계수(grad) 및 통계 지표(R2, syx, mse_val)를 반환합니다.
%
% 입력:
% X_data: 독립 변수 데이터 행렬. 각 열은 하나의 독립 변수(x1, x2, ...)를 나타냅니다.
%         크기: [n_data, m_vars]
% Y_data: 종속 변수 데이터 벡터.
%         크기: [n_data, 1]
%
% 출력:
% grad: 계수 벡터 [b1(상수항); b2; ...; bm+1]
% R2: 결정 계수 (Coefficient of Determination)
% syx: 추정값의 표준 오차 (Standard Error of the Estimate)
% mse_val: 평균 제곱 오차 (Mean Squared Error)

% 데이터 포인트 개수 (n)와 독립 변수 개수 (m_vars) 확인
[n_data, m_vars] = size(X_data);
m_coeffs = m_vars + 1; % 계수 개수 (상수항 포함)

% ----------------------------------------------------------------------
% 1. X 행렬 구성 (상수항을 위한 1열 추가)
% ----------------------------------------------------------------------
% X = [1, x1, x2, ..., xm]
X_matrix = [ones(n_data, 1), X_data];

% ----------------------------------------------------------------------
% 2. 최소 제곱법 정규 방정식 풀이
% ----------------------------------------------------------------------
% 정규 방정식: (X'X) * grad = X'Y
% MATLAB의 백슬래시(\) 연산자를 사용하여 grad를 계산합니다.
% grad = (X'X) \ (X'Y)
grad = X_matrix' * X_matrix \ (X_matrix' * Y_data);

% ----------------------------------------------------------------------
% 3. 예측값 (yp) 계산
% ----------------------------------------------------------------------
yp = X_matrix * grad;

% ----------------------------------------------------------------------
% 4. 통계 지표 계산
% ----------------------------------------------------------------------

% (a) 총 제곱합 (Total Sum of Squares, ST)
Y_mean = mean(Y_data);
ST = sum((Y_data - Y_mean).^2);

% (b) 잔차 제곱합 (Sum of Squares Residuals, SR)
SR = sum((Y_data - yp).^2);

% (c) 자유도 (df): n_data - m_coeffs
df = n_data - m_coeffs;

% (d) 평균 제곱 오차 (MSE) 및 추정값의 표준 오차 (syx)
% syx^2 = MSE = SR / df
mse_val = SR / df;
syx = sqrt(mse_val); % 추정값의 표준 오차

% (e) 결정 계수 (Coefficient of Determination, R^2)
R2 = (ST - SR) / ST;

% ----------------------------------------------------------------------
% 5. 상관 계수 r_corr (이 함수는 다중 회귀이므로 R2만 제공)
%    단순 선형 상관 계수는 다중 변수 모델의 적합도를 측정하지 않습니다.
% ----------------------------------------------------------------------

end
