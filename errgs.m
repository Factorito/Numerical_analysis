function ea =errgs(xl,xu,xopt,phi);
ea = (2-phi)*abs((xu-xl)/xopt)*100;
