k = 0.019;
dt = 2;

% 초기 온도 및 주변 온도 설정
T = 70;
Ta = 20;

% 테이블 헤더 출력
fprintf('  t (min)     T (C)      -k(T-Ta)     (dT/dt)_euler    relative error (%%)\n');
fprintf('-----------------------------------------------------------------------\n');

dv_dt_theory_init = -k * (T - Ta);
fprintf('%8.2f %10.2f %14.4f %16.4f %16.2f\n', 0, T, dv_dt_theory_init, dv_dt_theory_init, 0.00);

for t = dt : dt : 20
    T_old = T;


    T = T_old + dt * (-k * (T_old - Ta));

    dv_dt_theory = -k * (T_old - Ta);

    dv_dt_euler = (T - T_old) / dt;

    if abs(dv_dt_theory) > 1e-10
        relative_error = abs( (dv_dt_euler - dv_dt_theory) / dv_dt_theory ) * 100;
    else
        relative_error = 0;
    end

    % 결과 출력
    fprintf('%8.2f %10.2f %14.4f %16.4f %16.2f\n', t, T, dv_dt_theory, dv_dt_euler, relative_error);
end
