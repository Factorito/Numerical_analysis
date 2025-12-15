function [D, deriv_approx, error_approx] = richard_diffrent(f, x_target, h_init, es_desired)
% RICHARD_DIFF
% Richardson 외삽법을 사용하여 함수 f(x)의 x_target에서의 미분값을 계산합니다.
% 기본 근사값은 중심 차분 공식(Central Difference)을 사용합니다.
%
% 입력:
% f: 미분할 함수 핸들 (예: @(x) sin(x))
% x_target: 미분값을 구할 x 위치
% h_init: 초기 단계 크기 h
% es_desired: 원하는 근사 상대 오차(%)
%
% 출력:
% D: 최종 Richardson 외삽 테이블 (Triangular Matrix)
% deriv_approx: 최종 미분 근사값
% error_approx: 최종 근사 상대 오차 (%)

% --- 기본 설정 ---
if nargin < 4
    es_desired = 0.00001; % 기본 오차 기준값 (0.00001%)
end
if nargin < 3
    h_init = 0.1; % 기본 h 값
end

max_iterations = 10; % 최대 반복 횟수 (테이블 깊이)
D = zeros(max_iterations, max_iterations); % Richardson 테이블 초기화
h = h_init; % 현재 단계 크기
deriv_approx = 0;
error_approx = 100; % 초기 오차

fprintf('--------------------------------------------------------------------------\n');
fprintf('Richardson 외삽 미분 테이블 (중심차분 기반)\n');
fprintf('i(반복) | h(단계 크기) | O(h^2) (중심차분) | O(h^4) | O(h^6) | O(h^8) |\n');
fprintf('--------------------------------------------------------------------------\n');

for i = 1 : max_iterations

    % 1. 기본 미분 근사값 D(i, 1) 계산 (O(h^2) 중심 차분)
    % h는 항상 현재 반복에 맞는 단계 크기 (h_init, h_init/2, h_init/4, ...)
    
    % 중심 차분 공식: (f(x+h) - f(x-h)) / (2*h)
    D(i, 1) = (f(x_target + h) - f(x_target - h)) / (2 * h);
    
    % 2. Richardson 외삽 (D(i, j) 계산)
    % j: 외삽 차수 (2부터 i까지)
    for j = 2 : i
        % 외삽 공식: D(i, j) = (4^(j-1) * D(i, j-1) - D(i-1, j-1)) / (4^(j-1) - 1)
        power_of_4 = 4^(j-1);
        D(i, j) = (power_of_4 * D(i, j-1) - D(i-1, j-1)) / (power_of_4 - 1);
    end

    % 3. 수렴 확인 및 결과 출력

    deriv_approx = D(i, i); % 현재 반복에서 가장 정확한 추정값 (테이블의 대각선 요소)

    % 근사 오차 계산 (i > 1 일 때만 가능)
    if i > 1
        % 근사 오차: 현재 가장 높은 차수의 추정값(D(i, i))과 직전 추정값(D(i-1, i-1))을 비교
        error_approx = abs(D(i, i) - D(i-1, i-1)) / abs(D(i, i)) * 100;

        % --- 오차 추정값 이하 종료 조건 ---
        if error_approx < es_desired
            fprintf('%5d | %11.6f |', i, h);
            for j = 1 : i
                fprintf(' %10.6f |', D(i, j));
            end
            fprintf(' (Approx Err: %.2e%%)', error_approx);
            fprintf('\n수렴 완료: 근사 오차 %.6f%%가 목표 오차 %.6f%%보다 작습니다.\n', error_approx, es_desired);
            break;
        end
    end

    % 결과 테이블 행 출력
    fprintf('%5d | %11.6f |', i, h);
    for j = 1 : i
        fprintf(' %10.6f |', D(i, j));
    end
    fprintf(' (Approx Err: %.2e%%)', error_approx);
    fprintf('\n');

    % 단계 크기 갱신
    h = h / 2;
end

% 최종 수렴 값으로 D 테이블을 정리하여 반환
D = D(1:i, 1:i);

end
