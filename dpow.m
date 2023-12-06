function out = dpow(pow, delta_t)

cpow = throttle(delta_t);
if cpow >= 50 
    if pow >= 50 
        T = 5.0;
    else
        cpow = 60;
        if pow >= 35
            T = 1.0;
        elseif pow <= 10 
            T = 0.1;
        else
            T = 1.9 - 0.036*(cpow-pow);
        end
    end
else
    if pow >= 50 
        T = 5.0;
        cpow = 40;
    else
        if cpow-pow <= 25.0
            T = 1.0;
        else
            T = 1.9 - 0.036*(cpow-pow);
        end
    end
end

out=T*(cpow-pow);


end