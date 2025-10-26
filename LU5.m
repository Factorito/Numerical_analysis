function LU = LU5(A,b)
    [n,~] = size(A);
    Aug = A;
    L = eye(n); % L은 단위 행렬로 초기화

    for k = 1 : n-1
        for i = k+1 : n
            % 1. 소거 인자 L(i,k) 저장 (Aug(i,k) / Aug(k,k))
            L(i,k) = Aug(i,k) / Aug(k,k);

            % 2. 소거 작업: Aug(i,:) = Aug(i,:) - L(i,k) * Aug(k,:)
            Aug(i,:) = Aug(i,:) - L(i,k) * Aug(k,:);
        end
    end

    U = Aug;
    L
    U
    d=forw(L,b,n)
    x=backw(U,d,n)

    LU = [L U d x];

end
