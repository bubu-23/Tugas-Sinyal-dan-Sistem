t = 0:0.01:5;
x = @(t) (t>=0);
h = @(t) exp(-t).*(t>=0);

figure;
for tau_idx = 1:20:length(t)
    tau = t(tau_idx);
    f = @(tt) x(tt) .* h(tau - tt);
    y_tau = integral(f, 0, max(t));
    h_shifted = h(tau - t);
    product   = x(t) .* h_shifted;

    clf;
    subplot(3,1,1); plot(t, x(t)); ylim([0 1.2]);
    subplot(3,1,2); plot(t, h_shifted); ylim([0 1.2]);
    subplot(3,1,3); plot(t, product);
    title(['∫ = ' num2str(y_tau,'%0.3f')]); ylim([0 1.2]);

    pause(0.5);
end

