function x=backw(U,d,n)
    x = zeros(n,1);


    x(n) = d(n) / U(n,n);

    for i = n-1 : -1 : 1

        sum_of_products = U(i, i+1:n) * x(i+1:n);

        x(i) = (d(i) - sum_of_products) / U(i,i);
    endfor
end
