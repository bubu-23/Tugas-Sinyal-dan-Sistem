% --- Tabular Discrete Convolution (Modified Version) ---
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
n_start = k(1) + k(1);
n_end = k(end) + k(end); % ambil sampai full length
n = n_start:n_end;
y = zeros(1, length(n));

% Flip h[k]
h_flipped = fliplr(h);
k_flipped = -fliplr(k);

fprintf('=== TABULAR DISCRETE CONVOLUTION ===\n');
fprintf('x[k] = [1, 2, 3, 1]\n');
fprintf('h[k] = [1, 1, 2]\n\n');

% 3. PERFORM CONVOLUTION
for i = 1:length(n)
    current_n = n(i);

    % Cari overlap index
    [k_common, ix, ih] = intersect(k, k_flipped + current_n);

    product_values = zeros(size(k));
    h_shifted_values = zeros(size(k));
    if ~isempty(k_common)
        product_values(ix) = x(ix) .* h_flipped(ih);
        h_shifted_values(ix) = h_flipped(ih);
    end

    % Hitung jumlah
    y(i) = sum(product_values);

    % --- Display Table ---
    fprintf('----------------------------------------\n');
    fprintf('n = %d  -->  y[%d] = sum(x[k]*h[%d-k])\n', ...
        current_n, current_n, current_n);
    fprintf('----------------------------------------\n');
    fprintf('   k  |  x[k]  | h[%d-k] | Product\n', current_n);
    fprintf('----------------------------------------\n');

    for j = 1:length(k)
        fprintf(' %3d | %5.1f | %6.1f | %7.2f\n', ...
            k(j), x(j), h_shifted_values(j), product_values(j));
    end
    fprintf('----------------------------------------\n');
    fprintf(' y[%d] = %.2f\n\n', current_n, y(i));
end

% 4. Display final result as a table
disp('=== FINAL CONVOLUTION RESULT TABLE ===');
disp(table(n', y', 'VariableNames', {'n', 'y[n]'}));

% 5. Plot the final result
figure('Name', 'Discrete Convolution Result');
stem(n, y, 'm', 'filled', 'LineWidth', 1.5);
title('Final Convolved Signal y[n]');
xlabel('n');
ylabel('y[n]');
grid on;

