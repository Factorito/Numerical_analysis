y = 1;
rerr = relerr(1/2,y);
x = pi/3;
iter = 1;
bu = -1;

fprintf("---- iteration ---- value ---- rerr\n");
fprintf("---- %d ---- %f ---- %f \n",iter,y,rerr);

while(rerr*100>1)
y = y + bu*(x)^(iter*2)/factorial(iter*2);

rerr = relerr(1/2,y);
bu = -1 * bu;
iter = iter+1;

fprintf("---- %d ---- %f ---- %f \n",iter,y,rerr);

end
