function xi = jacobi(A, b, es_desired)
% Ax=b 연립방정식을 Jacobi 반복법으로 푸는 함수.
% Jacobi는 새로운 반복값을 계산할 때 이전 반복값만 사용합니다.

[m, n] = size(A);

% --- 오차 종료 조건을 위한 설정 ---
if nargin < 3
    es_desired = 0.00001; % 원하는 근사 상대 오차(%) 기준값 설정
end

xi = zeros(m, 1);   % 이전 해 벡터 x^(k) (초기 추측값)
xn = zeros(m, 1);   % 새로운 해 벡터 x^(k+1)
maxit = 50;         % 최대 반복 횟수

for i = 1 : maxit
    % 오차 계산을 위해 현재 해를 이전 해로 저장
    xi_old = xi; 

    for j = 1 : m % 각 방정식(행)에 대해 반복
        
        % Jacobi 공식의 우변 합계 계산 (i != j인 항만 사용, xi_old 값만 사용)
        sum_terms = A(j, 1:j-1) * xi_old(1:j-1) + A(j, j+1:n) * xi_old(j+1:n);
        
        % Jacobi 업데이트 공식: xn(j) = (b(j) - sum_terms) / A(j,j)
        xn(j) = (b(j) - sum_terms) / A(j,j);
        
    end

    % 다음 반복을 위해 새로운 해를 이전 해 변수에 업데이트
    xi = xn;

    % --- 오차 추정값 이하 종료 조건 ---
    es = abs(xn - xi_old) ./ abs(xn) .* 100;
    Ea = max(es); % 최대 근사 상대 오차
    
    if Ea < es_desired
        disp(['Jacobi 수렴. 반복 횟수: ', num2str(i), ', 최대 오차: ', num2str(Ea), '%.']);
        break; 
    end
    % --------------------------------------
end

if i == maxit && Ea >= es_desired
    warning('Jacobi 방법이 최대 반복 횟수 내에 수렴하지 않았습니다.');
end

end
