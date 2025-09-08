% Continuous-Time Convolution Integral (Improved Visualization)
clear; clc; close all;

t = 0:0.01:5;
dt = t(2) - t(1);

x = ones(size(t));                % x(t) = u(t)
h = exp(-t);                      % h(t) = e^{-t}u(t)

y = zeros(size(t));
for i = 1:length(t)
    tau = 0:dt:t(i);
    xtau = interp1(t, x, tau, 'linear', 0);
    htau = interp1(t, h, t(i)-tau, 'linear', 0);
    y(i) = trapz(tau, xtau .* htau);
end

% --- Figure 1: Subplots ---
figure('Name','Continuous Convolution','Position',[100 100 800 700]);

subplot(3,1,1);
plot(t, x, 'b', 'LineWidth', 2);
title('Input Signal x(t) = u(t)','FontSize',12,'FontWeight','bold');
xlabel('t','FontWeight','bold'); ylabel('Amplitude','FontWeight','bold');
grid on; axis tight; legend('x(t)');

subplot(3,1,2);
plot(t, h, 'r', 'LineWidth', 2);
title('Impulse Response h(t) = e^{-t}u(t)','FontSize',12,'FontWeight','bold');
xlabel('t','FontWeight','bold'); ylabel('Amplitude','FontWeight','bold');
grid on; axis tight; legend('h(t)');

subplot(3,1,3);
plot(t, y, 'm', 'LineWidth', 2);
title('Output y(t) = (x*h)(t)','FontSize',12,'FontWeight','bold');
xlabel('t','FontWeight','bold'); ylabel('Amplitude','FontWeight','bold');
grid on; axis tight; legend('y(t)');

% --- Figure 2: Combined plot ---
figure('Name','Combined Signals','Position',[950 100 700 500]);
plot(t, x, 'b', 'LineWidth', 2); hold on;
plot(t, h, 'r', 'LineWidth', 2);
plot(t, y, 'm', 'LineWidth', 2);
title('Signals in One Plot','FontSize',12,'FontWeight','bold');
xlabel('t','FontWeight','bold'); ylabel('Amplitude','FontWeight','bold');
grid on; axis tight;
legend('x(t)=u(t)','h(t)=e^{-t}u(t)','y(t)=(x*h)(t)');

