clear; clc; close all;

a = 0;
b = 0.5;
n_simpson = 320;
tol = 1e-10;
max_iter = 100;

Fa = 1;
Fb = computeF(b, n_simpson);

m = (Fb - Fa) / (b - a);

fprintf('F(0) = %.12f\n', Fa);
fprintf('F(0.5) = %.12f\n', Fb);
fprintf('m = %.12f\n\n', m);

N_sample = 11;
x_sample = linspace(a, b, N_sample);
y_sample = zeros(1, N_sample);

for i = 1:N_sample
    if x_sample(i) == 0
        y_sample(i) = 1;
    else
        y_sample(i) = computeF(x_sample(i), n_simpson);
    end
end

pp = spline(x_sample, y_sample);

h_diff = 1e-6;
F_interp = @(x) ppval(pp, x);
F_interp_prime = @(x) (F_interp(x + h_diff) - F_interp(x - h_diff)) / (2 * h_diff);

H = @(x) F_interp_prime(x) - m;

c = bisection(H, a, b, tol, max_iter);

fprintf('c = %.12f\n', c);
fprintf('F''(c) = %.12f\n', F_interp_prime(c));
fprintf('خطا = %.2e\n', abs(F_interp_prime(c) - m));

function c = bisection(f, a, b, tol, max_iter)
    fa = f(a);
    fb = f(b);
    
    if fa * fb > 0
        error('شرط f(a)*f(b) < 0 برقرار نیست');
    end
    
    for k = 1:max_iter
        c = (a + b) / 2;
        fc = f(c);
        
        if abs(fc) < tol || (b - a)/2 < tol
            return;
        end
        
        if fa * fc < 0
            b = c;
            fb = fc;
        else
            a = c;
            fa = fc;
        end
    end
    warning('حداکثر تکرار رسیده');
    c = (a + b) / 2;
end
