function out = throttle(delta_t)

    if delta_t <= 0.77
        out = 64.94*delta_t;
    else
        out = 217.38*delta_t-117.38;
    end
end