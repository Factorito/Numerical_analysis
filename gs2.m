function [xopt, fx] = gs2(f, xl, xu, maxit, es)
% 황금 분할 탐색법을 사용하여 함수 f의 최솟값을 찾습니다.
%
% [xopt, fx] = gs_refactored(f, xl, xu, maxit, es)
%   f: 함수 핸들 (예: @(x) x^2/10 - 2*sin(x))
%   xl, xu: 초기 탐색 구간
%   maxit: 최대 반복 횟수
%   es: 종료 오차 기준 (%)

phi = (1 + sqrt(5)) / 2;
R = phi - 1; % R = 0.618...
ea = 100;     % 초기 근사 오차를 충분히 큰 값으로 설정

% 초기 d 계산 및 내부점 x1, x2 계산
d = R * (xu - xl);
x1 = xl + d;
x2 = xu - d;
f1 = f(x1);
f2 = f(x2);

% 초기 최적값 추정치 설정
if f1 < f2
    xopt = x1;
    fx = f1;
else
    xopt = x2;
    fx = f2;
end

fprintf('\n-------------------------------------------------------------------\n');
fprintf('Iter |      xl      |      xu      |     xopt     |      d      |  ea (%%) \n');
fprintf('-------------------------------------------------------------------\n');

for i = 1:maxit
    % 현재 반복 결과 출력
    fprintf('%4d | %12.6f | %12.6f | %12.6f | %10.6f | %8.4f\n', i, xl, xu, xopt, d, ea);

    % 구간 축소
    if f1 < f2
        % x2 지점 제거, x1이 다음 반복에서 x2 역할을 수행
        xl = x2;
        x2 = x1; 
        f2 = f1; % f2를 f1 값으로 업데이트 (재계산 불필요)
        
        % 새로운 내부점 x1 계산
        d = R * (xu - xl);
        x1 = xl + d;
        f1 = f(x1);
        
        xopt = x1; % 새로운 최적값 추정치
        fx = f1;
    else
        % x1 지점 제거, x2가 다음 반복에서 x1 역할을 수행
        xu = x1;
        x1 = x2;
        f1 = f2; % f1을 f2 값으로 업데이트 (재계산 불필요)
        
        % 새로운 내부점 x2 계산
        d = R * (xu - xl);
        x2 = xu - d;
        f2 = f(x2);
        
        xopt = x2; % 새로운 최적값 추정치
        fx = f2;
    end
    
    % 근사 상대 오차 계산 (2-phi = 1/phi^2)
    ea = (2 - phi) * abs((xu - xl) / xopt) * 100;

    % 종료 조건 검사
    if ea < es
        break;
    end
end

fprintf('-------------------------------------------------------------------\n');
fprintf('최적값 xopt = %f, 함수값 f(xopt) = %f\n', xopt, fx);
end
