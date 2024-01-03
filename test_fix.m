A0 = [1 1 1 1 1 1];
fun = @(x)fix_f(x);

[A, B] = fsolve(fun,A0);