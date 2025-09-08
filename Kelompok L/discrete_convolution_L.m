% Discrete-Time Convolution Visualization
x = [1 2 3 4];         % Input signal x[n]
h = [1 -1 2];           % Impulse response h[n]
N = length(x) + length(h) - 1;

figure;
for n = 0:N-1
    clf;
    k = 0:length(x)-1;
    hk = fliplr(h);                      % Flip h[n]
    hk_shifted = zeros(1, length(x));   % Shifted version
    for i = 1:length(h)
        if (n - i + 1 >= 1) && (n - i + 1 <= length(x))
            hk_shifted(n - i + 1) = hk(i);
        end
    end
    product = x .* hk_shifted;          % Multiply
    y_n = sum(product);                 % Sum

    subplot(3,1,1); stem(k, x, 'filled'); title('x[n]'); ylim([0 4]);
    subplot(3,1,2); stem(k, hk_shifted, 'filled'); title(['h[n-' num2str(n) '] (flipped & shifted)']); ylim([0 2]);
    subplot(3,1,3); stem(k, product, 'filled'); title(['x[k] * h[n-k], sum = ' num2str(y_n)]); ylim([0 6]);

    pause(2);  % Pause to animate each step
end
