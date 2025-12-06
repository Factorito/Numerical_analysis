function xi = gauss_Seidel(A,b, w, es_desired) % w (omega)와 es_desired를 입력으로 추가

[m,n] = size(A);
M = tril(A);
N = M-A;
xi = zeros(m,1); % 이전 반복값
xn = zeros(m,1); % 새로운 반복값

% --- 상이완법(SOR)을 위한 설정 ---
if nargin < 3
    w = 1; % w=1 일 경우 일반 Gauss-Seidel (상이완법 비적용)
end
% --- 오차 종료 조건을 위한 설정 ---
if nargin < 4
    es_desired = 0.00001; % 원하는 근사 상대 오차(%) 기준값 설정
end

maxit = 50; % 반복 횟수를 좀 더 현실적인 값으로 조정 (원래 코드에서는 5)

for i = 1 : maxit
    % 오차 계산을 위해 현재 반복 전의 값을 저장
    xi_old = xi; 

    % --- 상이완법 (SOR) 적용 주석 및 코드 추가 ---
    % 상이완법(SOR) 공식: xn(j) = w * xn_GS + (1-w) * xi(j);
    
    % x(1) 업데이트 (Gauss-Seidel 업데이트 공식)
    x_gs_1 = (b(1)-sum(A(1,2:n)*xi(2:n)))/A(1,1);
    xn(1) = w * x_gs_1 + (1-w) * xi_old(1); % <-- SOR (상이완법) 적용
    
    % x(2) 업데이트
    x_gs_2 = (b(2)-sum(A(2,3:n)*xi(3:n)-A(2,1:1)*xn(1)))/A(2,2);
    xn(2) = w * x_gs_2 + (1-w) * xi_old(2); % <-- SOR (상이완법) 적용
    
    % x(3) 업데이트
    x_gs_3 = (b(3)-sum(A(3,1:2)*xn(1:2)))/A(3,3);
    xn(3) = w * x_gs_3 + (1-w) * xi_old(3); % <-- SOR (상이완법) 적용
    % -------------------------------------------------------------------

    % 근사 상대 오차(%) 계산
    es = abs(xn-xi_old)./abs(xn).*100;
    
    % 다음 반복을 위해 현재 해를 이전 해로 업데이트
    xi=xn;

    % --- 오차 추정값 이하 종료 조건 추가 ---
    Ea = max(es); % 최대 근사 상대 오차를 구함
    
    if Ea < es_desired
        disp(['오차 기준 만족으로 반복 종료. 반복 횟수: ', num2str(i), ', 최대 오차: ', num2str(Ea), '%.']);
        break; 
    end
    % --------------------------------------

end

% 최종 해는 xi에 저장되어 반환됩니다.
