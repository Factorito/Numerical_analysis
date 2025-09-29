function [root, fx, ea, iter] = bisect(func, xl, xu, es, maxit, varargin)
 % bisect: root location zeroes
 % [root,fx,ea,iter]=bisect(func,xl,xu,es,maxit,p1,p2,...):
 % uses bisection method to find the root of func
 % input:
 % func = name of function
 % xl, xu = lower and upper guesses
 % es = desired relative error (default = 0.0001%)
 % maxit = maximum allowable iterations (default = 50)
 % p1,p2,... = additional parameters used by func
 % output:
 % root = real root
 % fx = function value at root
 % ea = approximate relative error (%)
 % iter = number of iterations

 if nargin < 3
    error('at least 3 input arguments required');
 end

 % 초기 근 탐색 테스트
 test = func(xl, varargin{:}) * func(xu, varargin{:});
 if test > 0
    error('no sign change');
 end

 % 기본값 설정 (논리 연산자 OR: | -> || 또는 | 사용)
 if nargin < 4 || isempty(es)
    es = 0.0001;
 end
 if nargin < 5 || isempty(maxit)
    maxit = 50;
 end

 iter = 0;
 xr = xl; % xr 초기화
 ea = 100;

 while (1)
    xrold = xr;
    % 산술 연산자 빼기: − -> - (하이픈) 으로 수정
    xr = (xl + xu) / 2;
    iter = iter + 1;

    % 같지 않음 연산자: ~ = -> ~= 으로 수정
    if xr ~= 0
       % 산술 연산자 빼기: − -> - (하이픈) 으로 수정
       ea = abs((xr - xrold) / xr) * 100;
    end

    test = func(xl, varargin{:}) * func(xr, varargin{:});

    if test < 0
       xu = xr;
    elseif test > 0
       xl = xr;
    else
       ea = 0;
    end

    % 논리 연산자 OR: | -> || 또는 | 사용
    if ea <= es || iter >= maxit
       break;
    end
 end

 root = xr;
 fx = func(xr, varargin{:});

end
