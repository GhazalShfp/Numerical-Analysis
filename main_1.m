% MAIN_1
% Equation 2:
% F(x) = 1 + int_0^{tan(x)} cos(e^t) dt ,  x in (0, 0.5)
% piade sazie ravesh simpson morabayee
% baresi hamgerayee baraye noghat mord nazar
% v baresy plot f(x) dar baze mord nazar

clear;
clc;
close all;

%% ------------------------------------------------------------------
%  1) Convergence study at a fixed interior point

xTest = 0.25;
nList = [20, 40, 80, 160, 320];
Fvals = zeros(size(nList));

fprintf('Convergence study for F(%.4f):\n', xTest);
fprintf('----------------------------------------\n');
fprintf('   n     |     F(x)\n');
fprintf('----------------------------------------\n');

for i = 1:length(nList)
    Fvals(i) = computeF(xTest, nList(i));
    fprintf('%6d   |  %.12f\n', nList(i), Fvals(i));
end

% Absolute differences between successive refinements
if length(Fvals) > 1
    diffs = abs(diff(Fvals));
    fprintf('\nAbsolute differences |F_n - F_{n/2}|:\n');
    for i = 1:length(diffs)
        fprintf('  n=%d vs n=%d : %.3e\n', nList(i+1), nList(i), diffs(i));
    end
end

%% ------------------------------------------------------------------
%  2) Sample points of F(x) on (0, 0.5)

xSamples = [0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40, 0.45];
nDefault = 320;
Fsamples = computeF(xSamples, nDefault);

fprintf('\nSample values of F(x) with n = %d:\n', nDefault);
fprintf('----------------------------------------\n');
fprintf('   x      |     F(x)\n');
fprintf('----------------------------------------\n');
for i = 1:length(xSamples)
    fprintf('%6.2f   |  %.12f\n', xSamples(i), Fsamples(i));
end

%% ------------------------------------------------------------------
%  3) Plot F(x) on (0, 0.5)

xPlot = linspace(0.01, 0.49, 100);
Fplot = computeF(xPlot, nDefault);

figure('Name', 'F(x) - Equation 2 - group2', 'Color', 'w');
plot(xPlot, Fplot, 'b-', 'LineWidth', 1.8);
hold on;
plot(xSamples, Fsamples, 'ro', 'MarkerSize', 7, 'MarkerFaceColor', 'r');
grid on;
xlabel('x');
ylabel('F(x)');
title('F(x) = 1 + \int_0^{tan(x)} cos(e^t) dt   on  (0, 0.5)');
legend('F(x) (Simpson composite)', 'Sample points', 'Location', 'best');
xlim([0, 0.5]);


figure('Name', 'Convergence of F(x) curves', 'Color', 'w');
hold on;
colors = lines(length(nList));
for i = 1:length(nList)
    Fi = computeF(xPlot, nList(i));
    plot(xPlot, Fi, 'Color', colors(i,:), 'LineWidth', 1.2, ...
        'DisplayName', sprintf('n = %d', nList(i)));
end
grid on;
xlabel('x');
ylabel('F(x)');
title('Convergence of Composite Simpson approximations of F(x)');
legend('Location', 'best');
xlim([0, 0.5]);

fprintf('\nDone:).\n');
