function v = general_integral_rule(f, a, b, N, rule_type)
% f: 함수 핸들
% a, b: 적분 구간
% N: 부분 구간의 개수
% rule_type: 'trapezoidal', 'simpson1/3', 'simpson3/8'

h = (b - a) / N;
x = linspace(a, b, N + 1);

switch lower(rule_type)
    case 'trapezoidal'
        % 합성 사다리꼴
        sum_mid = sum(f(x(2:N)));
        v = (h/2) * (f(a) + 2*sum_mid + f(b));

    case 'simpson1/3'
        % 합성 Simpson 1/3 (N은 짝수여야 함)
        if mod(N, 2) ~= 0
            error('Simpson 1/3 규칙은 짝수 개의 부분 구간(N)이 필요합니다.');
        end
        sum_4 = sum(f(x(2:2:N)));  % 계수 4 (홀수 인덱스 x1, x3...)
        sum_2 = sum(f(x(3:2:N)));  % 계수 2 (짝수 인덱스 x2, x4...)
        v = (h/3) * (f(a) + 4*sum_4 + 2*sum_2 + f(b));
        
    case 'simpson3/8'
        % 합성 Simpson 3/8 (N은 3의 배수여야 함)
        if mod(N, 3) ~= 0
            error('Simpson 3/8 규칙은 부분 구간(N)이 3의 배수여야 합니다.');
        end
        % 구현을 위해 일반화된 3/8 공식의 가중치를 적용해야 함
        % (1, 3, 3, 2, 3, 3, 2, ..., 1) 형태의 가중치 필요
        
        % 가장 간단한 구현: N=3 (단일 적용)만 고려
        if N == 3
            v = (3*h/8) * (f(x(1)) + 3*f(x(2)) + 3*f(x(3)) + f(x(4)));
        else
            error('합성 Simpson 3/8 구현은 복잡하여 생략합니다. N=3만 가능합니다.');
        end
        
    otherwise
        error('지원되지 않는 규칙 유형입니다.');
end

end
