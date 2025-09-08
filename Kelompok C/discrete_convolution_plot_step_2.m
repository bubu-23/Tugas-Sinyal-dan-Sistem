% --- Step-by-Step Discrete Convolution with Calculations (Modified) ---
clear; clc; close all;

% 1. DEFINE SIGNALS
k = -2:10;
x = (k >= 0 & k <= 4);                % Rectangular pulse
h = (0.8).^k .* (k >= 0 & k <= 6);    % Decaying ramp

% 2. INITIALIZE FOR CONVOLUTION
n_start = min(k) + min(k);
n_end   = max(k) + max(k);
n = n_start:n_end;
y = zeros(1, length(n));

% Flip h[k] untuk h[-k]
h_flipped = fliplr(h);
k_flipped = -fliplr(k);

% 3. PERFORM CONVOLUTION STEP-BY-STEP
figure('Name', 'Discrete Convolution Steps', 'Position', [100, 100, 900, 700]);

for i = 1:length(n)
    current_n = n(i);

    % Clear figure
    clf;

    % --- Visualization ---
    % Plot x[k]
    subplot(4, 1, 1);
    stem(k, x, 'b', 'filled', 'LineWidth', 1.5);
    ylabel('x[k]'); grid on; xlim([n_start, n_end]);

    % Plot flipped & shifted h[n-k]
    subplot(4, 1, 2);
    stem(k_flipped + current_n, h_flipped, 'r', 'filled', 'LineWidth', 1.5);
    ylabel('h[n-k]'); grid on; xlim([n_start, n_end]);

    % --- Calculation ---
    [k_common, ix, ih] = intersect(k, k_flipped + current_n);
    product = zeros(1, length(k));
    if ~isempty(k_common)
        product(ix) = x(ix) .* h_flipped(ih);
    end
    y(i) = sum(product);

    % Plot product
    subplot(4, 1, 3);
    stem(k, product, 'g', 'filled', 'LineWidth', 1.5);
    ylabel('Product'); grid on; xlim([n_start, n_end]);

    % Plot partial result
    subplot(4, 1, 4);
    stem(n, y, 'm', 'filled', 'LineWidth', 1.5);
    ylabel('y[n]'); xlabel('n'); grid on; xlim([n_start, n_end]);

    % --- Display calculation string ---
    non_zero_elements = product(product ~= 0);
    if isempty(non_zero_elements)
        sum_str = '0';
    else
        sum_str = strjoin(arrayfun(@(val) sprintf('%.2f', val), ...
                     non_zero_elements, 'UniformOutput', false), ' + ');
    end
    sgtitle(sprintf('Step %d/%d → y[%d] = %s = %.2f', ...
        i, length(n), current_n, sum_str, y(i)));

    pause(1); % Pause tiap step
end

% 4. FINAL RESULT
disp('Final convolved signal y[n]:');
disp(y);

% Bandingkan dengan fungsi conv()
y_builtin = conv(x, h);
figure('Name', 'Comparison with MATLAB conv');
stem(n, y, 'm', 'filled', 'LineWidth', 1.5); hold on;
stem((min(k)+min(k)):(max(k)+max(k)), y_builtin, 'b--');
legend('Step-by-step result','MATLAB conv()');
title('Comparison of Convolution Results');
xlabel('n'); ylabel('y[n]'); grid on;