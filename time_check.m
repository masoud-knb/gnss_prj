function time_c = time_check(time)
    half_week = 302400;
    time_c = time;

    if time > half_week
        time_c = time - 2*half_week;
    elseif time < -half_week
        time_c = time + 2*half_week;
    end
end