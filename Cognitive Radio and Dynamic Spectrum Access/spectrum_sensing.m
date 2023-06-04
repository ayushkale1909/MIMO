% Signal Generation
M = 16;  % Size of signal 
k = log2(M);  % Number of bits per symbol
numSamples = 1000;  % Number of symbols being transmitted

data = randi([0 1], numSamples, k);  % Binary data 
txSignal = qammod(data, M);  % Modulation

% Noise Addition
SNR = 10;  % Signal to Noise Ratio
rxSignal = awgn(txSignal, SNR);  % Received signal

% Energy Detection
energy = abs(rxSignal).^2;
threshold = 10;  % Arbitrary threshold

if mean(energy) > threshold
    disp('Primary user detected');
else
    disp('Spectrum hole detected');
end
