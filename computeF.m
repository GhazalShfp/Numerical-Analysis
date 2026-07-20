function Fx = computeF(x, n)
%   COMPUTEF Evaluate F(x) = 1 + integral_0^{tan(x)} cos(exp(t)) dt.
%   uses Composite Simpson's Rule with n subintervals.
%   If n is omitted, a default of 320 is used.
%   x may be a scalar or a vector; output matches size of x.
    if nargin < 2
        n = 320;
    end
    if any(x <= 0) || any(x >= 0.5)
        warning('computeF: x should lie in (0, 0.5) for the assigned interval.');
    end
    Fx = zeros(size(x));
    for k = 1:numel(x)
        upper = tan(x(k));
        integralValue = simpsonf(@computeIntegrand, 0, upper, n);
        Fx(k) = 1 + integralValue;
    end
end

function y = computeIntegrand(t)
%   Compute the value of the integrand cos(e^t) for every t.
%   تابع به صورت برداری نوشته شده.
    y = cos(exp(t));
end