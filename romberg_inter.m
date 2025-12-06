function [R, yint, error_approx] = romberg_integration(f, a, b, t_val, es_desired)
% ROMBERG_INTEGRATION
% Richardson 외삽법을 사용하여 함수 f(x)의 Romberg 적분을 수행합니다.
% 목표 오차(es_desired) 내에서 수렴할 때까지 반복 계산합니다.
%
% 입력:
% f: 적분할 함수 핸들 (예: @(x) 1/x)
% a: 적분 구간 하한
% b: 적분 구간 상한
% t_val: 적분의 참값 (오차 계산용, 선택 사항)
% es_desired: 원하는 근사 상대 오차(%)
%
% 출력:
% R: 최종 Romberg 적분 테이블 (Triangular Matrix)
% yint: 최종 적분 근사값
% error_approx: 최종 근사 상대 오차 (%)

% --- 기본 설정 ---
if nargin < 5
    es_desired = 0.00001; % 기본 오차 기준값 (0.00001%)
end
if nargin < 4
    t_val = NaN; % 참값 없을 경우 NaN 처리
end

max_iterations = 10; % 최대 반복 횟수 (테이블 깊이)
R = zeros(max_iterations, max_iterations); % Romberg 테이블 초기화
h = b - a; % 초기 단계 크기
yint = 0;
error_approx = 100; % 초기 오차

fprintf('--------------------------------------------------------------------------\n');
fprintf('Romberg 적분 계산 테이블 (Richardson 외삽)\n');
fprintf('i(반복) | h(단계 크기) | O(h^2) (사다리꼴) | O(h^4) | O(h^6) | O(h^8) |\n');
fprintf('--------------------------------------------------------------------------\n');

for i = 1 : max_iterations
    
    % 1. 사다리꼴 공식 (O(h^2) 근사값 R(i, 1) 계산)
    
    if i == 1
        % R(1, 1): h0 = b-a (사다리꼴 1개)
        R(i, 1) = h * (f(a) + f(b)) / 2;
    else
        % R(i, 1): h = h/2로 새로운 중간점 2^(i-2) 개를 추가하여 계산
        
        % 새로운 점들에서의 함숫값 합계 계산
        num_new_points = 2^(i-2); 
        sum_new = 0;
        for j = 1 : num_new_points
            % f(a + (2*j - 1) * h) 는 새로 추가된 중간점에서의 f(x) 값
            sum_new = sum_new + f(a + (2*j - 1) * h);
        end
        
        % 복합 사다리꼴 공식 적용: R(i, 1) = 1/2 * R(i-1, 1) + h * sum(새로운 f(x) 값)
        R(i, 1) = 0.5 * R(i-1, 1) + h * sum_new;
    end
    
    % 2. Richardson 외삽 (R(i, j) 계산)
    % j: 외삽 차수 (2부터 i까지)
    for j = 2 : i
        % Romberg 외삽 공식: R(i, j) = (4^(j-1) * R(i, j-1) - R(i-1, j-1)) / (4^(j-1) - 1)
        power_of_4 = 4^(j-1);
        R(i, j) = (power_of_4 * R(i, j-1) - R(i-1, j-1)) / (power_of_4 - 1);
    end
    
    % 3. 수렴 확인 및 결과 출력
    
    yint = R(i, i); % 현재 반복에서 가장 정확한 추정값 (테이블의 대각선 요소)
    
    % 참값이 주어졌을 경우 참 오차 계산
    if ~isnan(t_val)
        error_true = abs(t_val - yint);
    else
        error_true = NaN;
    end
    
    % 근사 오차 계산 (i > 1 일 때만 가능)
    if i > 1
        % 근사 오차는 R(i, i)와 R(i-1, i-1) 또는 R(i, i)와 R(i, i-1)을 사용할 수 있으나,
        % 일반적으로는 현재 가장 높은 차수의 추정값(R(i, i))과 직전 추정값(R(i-1, i-1) 또는 R(i, i-1))을 비교합니다.
        % 여기서는 Romberg 테이블의 대각선 값 R(i, i)와 R(i-1, i-1)을 비교하여 계산합니다.
        error_approx = abs(R(i, i) - R(i-1, i-1)) / abs(R(i, i)) * 100;

        % --- 오차 추정값 이하 종료 조건 ---
        if error_approx < es_desired
            fprintf('수렴 완료: 근사 오차 %.6f%%가 목표 오차 %.6f%%보다 작습니다.\n', error_approx, es_desired);
            break;
        end
    end
    
    % 단계 크기 갱신
    h = h / 2;
    
    % 결과 테이블 행 출력
    fprintf('%5d | %11.6f |', i, h*2); % h*2는 해당 반복 직전의 단계 크기
    for j = 1 : i
        fprintf(' %10.6f |', R(i, j));
    end
    fprintf(' (True Err: %.2e, Approx Err: %.2e%%)', error_true, error_approx);
    fprintf('\n');

end

% 최종 수렴 값으로 R 테이블을 정리하여 반환
R = R(1:i, 1:i);

end
