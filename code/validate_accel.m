function accel = validate_accel(h, vel, u, dt, hsafe, vbounds, ubounds)
    % Makes sure that we don't supply to high or low of an acceleration and
    % checks that we don't apply an acceleration when we're within the safety
    % distance between cars.
    % h: headway
    % accel: current acceleration
    % hsafe: safety distance
    % ubounds(1): maximum acceleration
    % ubounds(2): minimum acceleration
    new_vel = vel + u*dt;

    if h <= hsafe
        u = 0;
    end
    if u < 0 & vel <= 0
        u = 0;
    end
    if u > ubounds(1)
        u = ubounds(1);
    end
    if u < ubounds(2)
        u = ubounds(2);
    end

    if new_vel > vbounds
        u = 0;
    end
    accel = u;
end
