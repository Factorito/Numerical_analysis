k = 0.08;
dt = 0.25;

% 초기 반지름 및 부피 설정
r = 1.25;
V = (4/3)*pi*r^3;

% 테이블 헤더 출력
fprintf('  t (sec)    V (cm^3)     -kA (이론)      (dV/dt)_euler     상대 오차 (%%)\n');
fprintf('----------------------------------------------------------------------\n');

for t = 0.25 : dt : 10

    V_old = V;


    A = 4 * pi * r^2;


    V = V + dt * (-k * A);

    if V <= 0
        V = 0;
    end

    r = (3 * V / (4 * pi))^(1/3);


    dv_dt_theory = -k * A;


    dv_dt_euler = (V - V_old) / dt;

   relative_error = abs( (dv_dt_euler - dv_dt_theory) / dv_dt_theory ) * 100;



    % 결과 출력
    fprintf('%8.2f %10.2f %14.4f %16.4f %.8f\n', t, V, dv_dt_theory, dv_dt_euler, relative_error);
end
