
%% ========================================================================
clear;
clc;
close all;

%% ------------------------------------------------------------------
%  1) بازه پروژه برای این گروه
a = 0.0;
b = 0.5;


n_outer = 40;     % باید زوج باشد
avgF = simpsonf(@(t) computeF(t), a, b, n_outer) / (b - a);

fprintf('مقدار میانگین انتگرالی F روی [%.2f , %.2f] = %.12f\n', a, b, avgF);


g = @(x) computeF(x) - avgF;

%% ------------------------------------------------------------------
fprintf('\n--- اجرای نیوتن-رافسون با x0 = 0.25 ---\n');
[c_est, iterInfo] = newtonRaphson(g, 0.25, 1e-10, 50, true);
fprintf('\nریشه یافت شده: c = %.12f\n', c_est);
fprintf('بررسی: F(c) = %.12f   ,   میانگین = %.12f\n', computeF(c_est), avgF);

fprintf('\n--- بررسی حساسیت به حدس اولیه ---\n');
guesses = [0.01, 0.05, 0.10, 0.25, 0.40, 0.49];
for i = 1:length(guesses)
    x0 = guesses(i);
    fprintf('\nحدس اولیه x0 = %.3f :\n', x0);
    try
        [cc, ~] = newtonRaphson(g, x0, 1e-10, 50, false);
        if cc < a || cc > b
            fprintf('  همگرا شد اما خارج از بازه است -> رد شد (c=%.6f)\n', cc);
        else
            fprintf('  همگرا شد -> c = %.12f\n', cc);
        end
    catch ME
        fprintf('  همگرا نشد (%s)\n', ME.message);
    end
end

%% ----------------------------------------------------------------
fprintf('\n--- بررسی همگرایی avgF و c نسبت به n_outer ---\n');
nList = [10, 20, 40, 80, 160];
cList  = zeros(size(nList));
avgList = zeros(size(nList));
for i = 1:length(nList)
    nn = nList(i);
    avg_nn = simpsonf(@(t) computeF(t), a, b, nn) / (b - a);
    g_nn = @(x) computeF(x) - avg_nn;
    [c_nn, ~] = newtonRaphson(g_nn, 0.25, 1e-10, 50, false);
    avgList(i) = avg_nn;
    cList(i)   = c_nn;
    fprintf('n_outer = %4d :  avgF = %.12f ,  c = %.12f\n', nn, avg_nn, c_nn);
end

%% ------------------------------------------------------------------

figure('Name', 'Convergence of c - Person 2', 'Color', 'w');
plot(nList, cList, 'o-', 'LineWidth', 1.6, 'MarkerFaceColor', 'b');
grid on;
xlabel('n_{outer}');
ylabel('c');
title('همگرایی مقدار c نسبت به تعداد زیربازه‌های انتگرال بیرونی');

fprintf('\nDone :)\n');


function [c, history] = newtonRaphson(g, x0, tol, maxit, verbose)
%   NEWTONRAPHSON  ریشه‌یابی عددی با روش نیوتن-رافسون از پایه.
%   مشتق g با تفاضل مرکزی عددی محاسبه می‌شود (بدون مشتق‌گیری نمادین).
%
%   g       : function handle,  g(x) = F(x) - avgF
%   x0      : حدس اولیه
%   tol     : معیار توقف روی |x_new - x_old|
%   maxit   : حداکثر تعداد تکرار
%   verbose : اگر true باشد، هر تکرار چاپ می‌شود

    if nargin < 5
        verbose = false;
    end

    h = 1e-6;              % گام تفاضل مرکزی برای مشتق عددی
    x = x0;
    history = zeros(maxit, 1);

    for k = 1:maxit
        gx  = g(x);
        dgx = (g(x + h) - g(x - h)) / (2*h);   % مشتق عددی g

        if abs(dgx) < 1e-14
            error('مشتق خیلی نزدیک به صفر شد؛ نیوتن-رافسون همگرا نشد.');
        end

        xnew = x - gx / dgx;
        history(k) = xnew;

        if verbose
            fprintf('  iter %2d :  x = %.12f   g(x) = %.3e\n', k, xnew, g(xnew));
        end

        if abs(xnew - x) < tol
            c = xnew;
            history = history(1:k);
            return;
        end
        x = xnew;
    end

    error('نیوتن-رافسون در %d تکرار همگرا نشد.', maxit);
end
