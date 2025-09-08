% --- Step-by-Step Continuous Convolution (Modified Version) ---
% Clear environment
clear; clc; close all;

% 1. DEFINE SIGNALS
dt = 0.05;                    % Time resolution
tau = -2:dt:8;                % Dummy variable (integration axis)

% Signal x(tau) : rectangular pulse
x = (tau >= 0 & tau <= 2);

% Signal h(tau) : triangular pulse (center = 1, width = 2)
h = tripuls(tau - 1, 2);

% 2. INITIALIZE FOR CONVOLUTION
t_start = tau(1) + tau(1);
t_end   = tau(end) + tau(end);
t       = t_start:dt:t_end;   % Output time axis
y       = zeros(1, length(t));

% Flip h(tau) → h(-tau)
h_flipped = fliplr(h);
tau_flipped = -fliplr(tau);

% 3. STEP-BY-STEP VISUALIZATION
figure('Name', 'Continuous Convolution Steps', 'Position', [100, 100, 900, 700]);

t_visual_indices = 1:5:length(t); % Plot every 5th step

for i = t_visual_indices
    current_t = t(i);

    % Interpolate shifted h(t - tau) onto tau grid
    h_shifted = interp1(tau_flipped + current_t, h_flipped, tau, 'linear', 0);

    % Element-wise multiplication
    product = x .* h_shifted;

    % Approximate integral
    y(i) = sum(product) * dt;

    % --- Visualization ---
    clf;

    % (1) Plot x(tau)
    subplot(4,1,1);
    plot(tau, x, 'b', 'LineWidth', 1.5);
    legend('x(\tau)', 'Location', 'NorthEast'); legend boxoff;
    ylabel('x(\tau)'); grid on; ylim([0 1.2]);
    xlim([t_start t_end]);
    title(['Step for t = ', num2str(current_t, '%.2f')]);

    % (2) Plot shifted h(t-tau)
    subplot(4,1,2);
    plot(tau, h_shifted, 'r', 'LineWidth', 1.5);
    legend('h(t-\tau)', 'Location', 'NorthEast'); legend boxoff;
    ylabel('h(t-\tau)'); grid on; ylim([0 1.2]);
    xlim([t_start t_end]);

    % (3) Plot product x(tau)*h(t-tau)
    subplot(4,1,3);
    fill(tau, product, 'g', 'FaceAlpha', 0.4, 'EdgeColor', 'g');
    legend('x(\tau)h(t-\tau)', 'Location', 'NorthEast'); legend boxoff;
    ylabel('Product'); grid on; ylim([0 1.2]);
    xlim([t_start t_end]);

    % (4) Build y(t)
    subplot(4,1,4);
    plot(t(1:i), y(1:i), 'm', 'LineWidth', 2);
    legend('y(t)', 'Location', 'NorthEast'); legend boxoff;
    xlabel('t'); ylabel('y(t)'); grid on;
    xlim([t_start t_end]);

    % Show calculation formula
    calc_title = sprintf('y(%.2f) ≈ Σ [x(τ)·h(t-τ)]·Δτ = %.2f', current_t, y(i));
    title(calc_title);

    pause(0.05); % Animation speed
end

% 4. FINAL COMPUTATION (for all t)
for i = 1:length(t)
    h_shifted = interp1(tau_flipped + t(i), h_flipped, tau, 'linear', 0);
    product = x .* h_shifted;
    y(i) = sum(product) * dt;
end

% 5. Final result plot
figure('Name','Final Continuous Convolution');
plot(t, y, 'm', 'LineWidth', 2);
title('Final Result y(t) = (x*h)(t)');
xlabel('t'); ylabel('y(t)'); grid on;

