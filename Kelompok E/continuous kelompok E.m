% --- Robust Continuous-Time Convolution (simple, no interp1) ---
clear; clc; close all;

% time
t = 0:0.01:5;
dt = t(2) - t(1);
N = length(t);

% signals (causal, sampled)
x = ones(size(t));        % x(t) = u(t)
h = exp(-t);              % h(t) = e^{-t}u(t)

% numerical convolution using discrete conv scaled by dt
y_full = dt * conv(x, h);             % length = 2*N-1
t_full = (0:(length(y_full)-1)) * dt; % time vector for full convolution

% analytical solution for comparison (defined on t_full)
y_ana_full = (1 - exp(-t_full)) .* (t_full >= 0);

% cut hasil agar sesuai domain simulasi awal (0..5)
y = y_full(1:N);
y_ana = y_ana_full(1:N);

% plotting (pakai subplot agar kompatibel)
figure('Color','w','Position',[100 100 900 650]);

subplot(3,1,1);
plot(t, x, 'b', 'LineWidth', 1.6); grid on;
title('x(t) = u(t)'); ylabel('Amplitude'); ylim([0 1.2]);

subplot(3,1,2);
plot(t, h, 'r', 'LineWidth', 1.6); grid on;
title('h(t) = e^{-t}u(t)'); ylabel('Amplitude'); ylim([0 1.2]);

subplot(3,1,3);
plot(t, y, 'g', 'LineWidth', 2); hold on;
plot(t, y_ana, 'k--', 'LineWidth', 1.4); grid on;
title('y(t) = x * h (numerical vs analytical)');
xlabel('t'); ylabel('Amplitude');
legend('Numerical (dt·conv)','Analytical 1-e^{-t}','Location','southeast');
ylim([0 1.2]);

% numeric error info
max_abs_err = max(abs(y - y_ana));
fprintf('Max absolute error (numerical vs analytical) = %.3e\n', max_abs_err);

% optional: plot error in a separate figure
figure('Color','w','Position',[250 250 700 300]);
plot(t, y - y_ana, 'm','LineWidth',1.4); grid on;
title('Numerical - Analytical Error'); xlabel('t'); ylabel('Error');

