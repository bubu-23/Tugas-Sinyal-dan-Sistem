% --- Discrete-Time Convolution Visualization (Modified) ---
x = [1 2 3];       % Input signal x[n]
h = [1 1];         % Impulse response h[n]
N = length(x) + length(h) - 1;   % Length of convolution result
y = zeros(1, N);                 % Store result

figure('Name','Discrete-Time Convolution','Position',[100,100,800,600]);

for n = 0:N-1
    clf;
    k = 0:length(x)-1;

    % Flip h[n]
    hk = fliplr(h);