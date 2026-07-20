function I = simpsonf(f, a, b, n)
%   SIMPSONF  This function approximates the integral of f over [a,b]
%   using composite Simpson's rule with n subintervals.
%   f is a vectorized function handle (accepts a vector input).
    if n < 2 || mod(n, 2) ~= 0
        error('n must be a positive even integer.');
    end
    if a == b
        I = 0;
        return;
    end
    h = (b - a) / n;
    x = a + (0:n) * h;
    y = f(x);
    % composite Simpson weights: 1, 4, 2, 4, ..., 2, 4, 1
    weights = ones(1, n + 1);
    weights(2:2:n) = 4;
    weights(3:2:n-1) = 2;
    I = (h / 3) * sum(weights .* y);
end
