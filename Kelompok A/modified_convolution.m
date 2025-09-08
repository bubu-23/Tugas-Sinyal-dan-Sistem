% Discrete-Time Convolution Visualization (Modified)
x = [1 2 3];         % Input signal x[n]
h = [1 1];           % Impulse response h[n]
N = length(x) + length(h) - 1;

y = zeros(1, N);     % Output convolution result

figure;
for n = 0:N-1
    clf;
    k = 0:length(x)-1;        % index for x[n]
    hk = fliplr(h);           % Flip h[n]
    hk_shifted = zeros(1, length(x));   % Shifted version

    % Shifting process
    for i = 1:length(h)
        if (n - i + 1 >= 1) && (n - i + 1 <= length(x))
            hk_shifted(n - i + 1) = hk(i);
        end
    end

    % Multiply and sum
    product = x .* hk_shifted;
    y_n = sum(product);
    y(n+1) = y_n;   % Store convolution output

    % --- Plotting ---
    subplot(4,1,1);
    stem(k, x, 'b','filled'); grid on;
    title('Input Signal x[n]'); ylim([0 4]);

    subplot(4,1,2);
    stem(k, hk_shifted, 'r','filled'); grid on;
    title(['Flipped & Shifted h[n-' num2str(n) ']']); ylim([0 2]);

    subplot(4,1,3);
    stem(k, product, 'g','filled'); grid on;
    title(['Product x[k]*h[n-k], sum = ' num2str(y_n)]); ylim([0 6]);

    subplot(4,1,4);
    stem(0:n, y(1:n+1), 'm','filled'); hold on;
    plot(0:n, y(1:n+1), 'k--'); grid on;
    title('Convolution Output y[n] Building Up');
    ylim([0 max(y)+1]);

    pause(1);  % Pause to animate each step
end

disp('Hasil akhir konvolusi y[n] = ');
disp(y);

