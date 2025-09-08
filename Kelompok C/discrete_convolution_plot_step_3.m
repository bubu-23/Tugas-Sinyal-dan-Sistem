% --- Tabular Discrete Convolution ---
% Clear environment
clear; clc; close all;

% 1. DEFINE SIGNALS
% Define index k for the signals
k = 0:5;
% Signal x[k]
x = [1, 2, 3, 1, 0, 0];
% Signal h[k]
h = [1, 1, 2, 0, 0, 0];

% 2. INITIALIZE FOR CONVOLUTION
% The output signal y[n] will exist from the sum of the starting indices
% to the sum of the ending indices.
n_start = k(1) + k(1);
n_end = k(end) + k(end-2); % Adjusted end for a clearer example
n = n_start:n_end;
y = zeros(1, length(n));

% Flip h[k] to get h[-k] for the convolution process
h_flipped = fliplr(h);
k_flipped = -fliplr(k);

% The full range of indices we need to consider for the table
k_full_range = (n_start - length(k)):(n_end + length(k));

% 3. PERFORM CONVOLUTION & DISPLAY TABLES
fprintf('Starting Discrete Convolution...\n');
fprintf('x[k] = [1, 2, 3, 1] for k=0,1,2,3\n');
fprintf('h[k] = [1, 1, 2] for k=0,1,2\n\n');

for i = 1:length(n)
    current_n = n(i);

    % --- Calculation ---
    % Find overlapping indices for multiplication
    [k_common, ix, ih] = intersect(k, k_flipped + current_n);

    product_values = zeros(size(k));
    if ~isempty(k_common)
        product_values(ix) = x(ix) .* h_flipped(ih);
    end

    % Calculate the sum to get the convolution result for this n
    y(i) = sum(product_values);

    % --- Display Table for the current step ---
    fprintf('----------------------------------------\n');
    fprintf('Calculating for n = %d\n', current_n);
    fprintf('y[%d] = sum( x[k] * h[%d-k] )\n', current_n, current_n);
    fprintf('----------------------------------------\n');
    fprintf('  k   |  x[k]  | h[%d-k] | Product\n', current_n);
    fprintf('----------------------------------------\n');

    h_shifted_values = zeros(size(k));
    if ~isempty(k_common)
      h_shifted_values(ix) = h_flipped(ih);
    end

    for j = 1:length(k)
        fprintf(' %2d   |  %4.1f  | %5.1f   | %6.2f\n', ...
                k(j), x(j), h_shifted_values(j), product_values(j));
    end
    fprintf('----------------------------------------\n');
    fprintf('Sum (y[%d]): .................... = %.2f\n\n', current_n, y(i));

    pause(1); % Pause to read the table
end

% Plot the final result
figure('Name', 'Discrete Convolution Result');
stem(n, y, 'm', 'filled', 'LineWidth', 1.5);
title('Final Convolved Signal y[n]');
xlabel('n');
ylabel('y[n]');
grid on;
