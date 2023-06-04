% Signal Generation
M = 16;  % Size of signal constellation
k = log2(M);  % Number of bits per symbol
numSamples = 1000;  % Number of symbols being transmitted

data = randi([0 1], numSamples, k);  % Binary data 
txSignal = qammod(data, M);  % Modulation

% Performance with Different SNR Values
SNR_values = -10:10;  
prob_detection = zeros(size(SNR_values));  %Probabilty

for i = 1:length(SNR_values)
    % Noise Addition
    rxSignal = awgn(txSignal, SNR_values(i));

    % Energy Detection
    energy = abs(rxSignal).^2;

    % Detection Decision
    detection = mean(energy) > threshold;

    prob_detection(i) = mean(detection);
end

% Plot
plot(SNR_values, prob_detection);
xlabel('SNR (dB)');
ylabel('Probability of Detection');
title('Sensing Performance vs SNR');

