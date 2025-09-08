x = [1 2 3 4];
h = [1 -1 2];
N = length(x) + length(h) - 1;
y = zeros(1,N);

figure;
for n = 0:N-1
    clf;
    k = 0:length(x)-1;
    hk = fliplr(h);
    hk_shifted = zeros(1, length(x));
    for i = 1:length(h)
        idx = n - i + 1;
        if (idx >= 1) && (idx <= length(x))
            hk_shifted(idx) = hk(i);
        end
    end
    product = x .* hk_shifted;
    y_n = sum(product);
    y(n+1) = y_n;

    subplot(4,1,1); stem(k, x, 'filled'); title('x[n]'); ylim([min(x)-1 max(x)+2]);
    subplot(4,1,2); stem(k, hk_shifted, 'filled'); title(['h[n-' num2str(n) '] (flipped & shifted)']);
    subplot(4,1,3); stem(k, product, 'filled'); title(['x[k] * h[n-k], sum = ' num2str(y_n)]);
    subplot(4,1,4); stem(0:n, y(1:n+1), 'filled'); title('Hasil Konvolusi y[n]');

    pause(1);
end

