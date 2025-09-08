% --- Continuous-Time Convolution (Modified) ---
clear; clc; close all;

% 1. TIME AXIS
t = 0:0.01:5;
dt = t(2) - t(1);

% 2. DEFINE SIGNALS
% Option 1: Step input
x = ones(size(t));                % x(t) = u(t)
% Option 2: Rectangular pulse (0<=t<=2)
%x = (t>=0 & t<=2);                % uncomment untuk uji sinyal lain

h = exp(-t);                       % h(t) = e^{-t}u(t)

% 3. CONVOLUTION APPROXIMATION
y = zeros(size(t));
for i = 1:length(t)
    tau = 0:dt:t(i);
    xtau = interp1(t, x, tau, 'linear', 0);
    htau = interp1(t, h, t(i)-tau, 'linear', 0);
    y(i) = trapz(tau, xtau .* htau);
end

% 4. PLOTTING
figure;

subplot(3,1,1);
plot(t, x, 'LineWidth', 2);
title('x(t)'); xlabel('t'); ylabel('Amplitude'); grid on;

subplot(3,1,2);
plot(t, h, 'r', 'LineWidth', 2);
title('h(t)'); xlabel('t'); ylabel('Amplitude'); grid on;

subplot(3,1,3);
area(t, y, 'FaceColor', [0.2 0.6 1], 'FaceAlpha', 0.5);
hold on; plot(t, y, 'b', 'LineWidth', 2);
title('y(t) = x(t) * h(t)'); xlabel('t'); ylabel('Amplitude'); grid on;

