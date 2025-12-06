function [grad, R2, syx, mse_val, r_corr] = polynomial_fit_analysis(xd, yd, degree)
% POLYNOMIAL_FIT_ANALYSIS (확장 버전)
% 주어진 데이터에 대해 N차 다항식 곡선 맞춤을 수행하고,
% 계수(grad)와 함께 통계 지표(R2, syx, r_corr)를 반환합니다.
%
% 입력:
% xd: 독립 변수 데이터 벡터
% yd: 종속 변수 데이터 벡터
% degree: 맞춤을 원하는 다항식의 차수 (N)
%
% 출력:
% grad: 다항식의 계수 벡터 (a0, a1, ..., aN)
% R2: 결정 계수 (Coefficient of Determination)
% syx: 추정값의 표준 오차 (Standard Error of the Estimate)
% mse_val: 평균 제곱 오차 (Mean Squared Error) (분산 형태)
% r_corr: 상관 계수 (Correlation Coefficient) (선형성 지표)

n_data = length(xd); % 데이터 포인트 개수
N = degree;         % 다항식 차수
m_coeffs = N + 1;   % 계수 개수 (a0 ~ aN)

% 1. 정규 방정식 행렬 A 및 B 벡터 생성
A = zeros(m_coeffs, m_coeffs);
B = zeros(m_coeffs, 1);

for i = 1 : m_coeffs
    B(i) = sum(xd.^(i-1) .* yd);
    for j = 1 : m_coeffs
        A(i, j) = sum(xd.^(i-1 + j-1));
    end
end

% 2. 정규 방정식 풀이: grad = A \ B
grad = A \ B; % 계수 벡터 [a0; a1; ...; aN]

% 3. 맞춤된 곡선 값 예측
coeff = flipud(grad);
yp = polyval(coeff, xd);

% ----------------------------------------------------------------------
% 4. 통계 지표 계산
% ----------------------------------------------------------------------

% (a) 총 제곱합 (Total Sum of Squares, ST)
yd_mean = mean(yd);
ST = sum((yd - yd_mean).^2);

% (b) 잔차 제곱합 (Sum of Squares Residuals, SR)
SR = sum((yd - yp).^2);

% (c) 평균 제곱 오차 (MSE) 및 추정값의 표준 오차 (syx)
% syx^2 = MSE = SR / (n_data - m_coeffs)
mse_val = SR / (n_data - m_coeffs);
syx = sqrt(mse_val); % 추정값의 표준 오차 (Standard Error of the Estimate)

% (d) 결정 계수 (Coefficient of Determination, R^2)
R2 = (ST - SR) / ST;

% (e) 상관 계수 (Correlation Coefficient, r_corr)
% 결정 계수 R^2의 제곱근 (R^2는 다항식 맞춤의 경우, 상관 계수 r^2와 다름)
% 하지만, 여기서는 선형 관계를 나타내는 Pearson 상관 계수를 구하는 것이
% 더 일반적이므로, 이를 별도로 계산합니다.
% (참고: 단지 R2의 제곱근으로 정의할 수도 있지만, 일반적인 통계학 정의를 따릅니다.)

% Pearson 상관 계수 r
r_corr = sum((xd - mean(xd)) .* (yd - mean(yd))) / ...
    (sqrt(sum((xd - mean(xd)).^2)) * sqrt(sum((yd - mean(yd)).^2)));


% 5. 시각화 (선택 사항)
figure;
plot(xd, yd, 'o', 'DisplayName', 'Data Points');
hold on;
xr = min(xd):0.1:max(xd); 
p = polyval(coeff, xr);
plot(xr, p, '-', 'DisplayName', [num2str(N), '차 다항식 맞춤']);
xlabel('X Data');
ylabel('Y Data');
title(['Polynomial Fit (Degree ', num2str(N), ')']);
legend('show');
hold off;

end
