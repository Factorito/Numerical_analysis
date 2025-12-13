function xn = gauss_Seidel(A,b, w, es_desired)
% A: 계수 행렬, b: 상수 벡터, w: 이완 계수, es_desired: 목표 오차(%)

[n,m] = size(A);

if n ~= m
    error('행렬 A는 정방 행렬이어야 합니다.');
end
if size(b, 1) ~= n || size(b, 2) ~= 1
    error('벡터 b의 차원이 행렬 A와 일치하지 않거나 열벡터가 아닙니다.');
end
if any(diag(A) == 0)
    error('대각 원소 중에 0이 있습니다. 반복법을 적용할 수 없습니다.');
end

% --- 기본값 설정 ---
if nargin < 3
    w = 1; % w=1이면 일반 Gauss-Seidel
end
if nargin < 4
    es_desired = 0.00001; % 원하는 근사 상대 오차(%) 기준값 설정
end

maxit = 50; % 최대 반복 횟수

xi = zeros(n,1); % 이전 해 벡터 (초기값으로 0 사용)
xn = xi;         % 현재(새로운) 해 벡터

disp('SOR을 적용한 Gauss-Seidel 반복법 시작...');

for iter = 1 : maxit
    % 오차 계산을 위해 현재 반복 전의 값을 저장
    xi_old = xn;

    % 모든 미지수 x_i에 대해 반복 계산
    for i = 1 : n
        % 이전 반복에서 이미 수렴된 값(xn(1) ~ xn(i-1))과
        % 이전 반복 값(xi_old(i+1) ~ xi_old(n))을 사용

        % i-1까지의 새로운 x값들의 합 (이미 업데이트된 값)
        sum_old_new = 0;
        if i > 1
            sum_old_new = A(i, 1:i-1) * xn(1:i-1);
        end

        % i+1부터의 이전 x값들의 합 (아직 업데이트되지 않은 값)
        sum_old = 0;
        if i < n
            sum_old = A(i, i+1:n) * xi_old(i+1:n);
        end

        % Gauss-Seidel의 다음 반복 값 (x_gs) 계산
        x_gs = (b(i) - sum_old_new - sum_old) / A(i,i);

        % SOR (상이완법) 적용
        xn(i) = w * x_gs + (1 - w) * xi_old(i);
    end

    % 근사 상대 오차(%) 계산
    % 분모가 0이 되는 경우를 피하기 위해 xn이 0이 아닐 때만 계산
    es = abs(xn-xi_old) ./ abs(xn);
    es(isnan(es)) = 0; % xn=xi_old=0인 경우 NaN 방지
    es = es * 100;

    % 최대 근사 상대 오차를 구함
    Ea = max(es);

    % --- 종료 조건 검사 ---
    if Ea < es_desired
        disp(['오차 기준 만족으로 반복 종료. 반복 횟수: ', num2str(iter), ', 최대 근사 상대 오차: ', num2str(Ea), '%.']);
        return; % 함수 종료
    end
end

disp(['최대 반복 횟수 (', num2str(maxit), ') 도달. 수렴 실패 또는 반복 부족.']);

end
