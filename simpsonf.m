function I = simpsonf(f, a, b, n)
%   this function approximates the integral of f over [a,b]
%   Az ravesh Simpson morakab ba n zirbaze estefade mikonad.
%   f voroody bordary migire

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

    %   vazn haye simpson morakab : 1, 4, 2, 4, ..., 2, 4, 1
    weights = ones(1, n + 1);
    weights(2:2:n) = 4;
    weights(3:2:n-1) = 2;

    I = (h / 3) * sum(weights .* y);
end
