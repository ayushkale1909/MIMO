% 8x8 MIMO System Simulation - Spatial Multiplexing

% Number of transmit and receive antennas
Nt = 8; % Number of transmit antennas
Nr = 8; % Number of receive antennas

% Generate random transmit signal
txSignal = randi([0, 1], Nt, 1);

% Channel Matrix (Rayleigh fading)
H = (randn(Nr, Nt) + 1i * randn(Nr, Nt)) / sqrt(2);

% Add noise to the received signal
% noise = zeros(Nr, 1);
noise = (randn(Nr, 1) + 1i * randn(Nr, 1)) * 0.01;
% Transmitted signal
s = 2*txSignal - 1; % BPSK modulation, Map the bits to -1 and 1

% Received signal without any processing (Spatial Multiplexing)
y = H * s + noise;

% Zero-Forcing (ZF) detection
% H^H * y = H^H * H * s + H^H * noise
% (H^H * H)^-1 * H^H * y = s + (H^H * H)^-1 * H^H * noise
sHat = (H'*H)\(H'*y); % This is the decoded signal

% Map the decoded signals back to bits
decodedSignal = real(sHat) > 0;

% Calculate Bit Error Rate (BER)
errors = sum(txSignal ~= decodedSignal);
ber = errors / Nt;

% Display the results
disp("Transmitted Signal:");
disp(txSignal');
disp("Decoded Signal:");
disp(decodedSignal');
disp("Bit Error Rate (BER):");
disp(ber);


% Calculate Signal-to-Noise Ratio (SNR)
snr = 10 * log10(sum(abs(txSignal).^2) / sum(abs(noise).^2));

disp("Signal-to-Noise Ratio (SNR) in dB:");
disp(snr);


% Plot Transmitted Signal
figure;
stem(txSignal, 'b', 'filled');
title('Transmitted Signal');
xlabel('Symbol Index');
ylabel('Binary Value');

rxSignalSM = H * txSignal + noise;
% Plot Constellation Diagram for Received Signal
figure;
scatter(real(rxSignalSM), imag(rxSignalSM), 'r', 'filled');
title('Constellation Diagram - Received Signal');
xlabel('In-Phase');
ylabel('Quadrature');
axis square;

% Plot Received Signal
figure;
stem(decodedSignal, 'r', 'filled');
title('Received Signal');
xlabel('Symbol Index');
ylabel('Binary Value');

% Plot Channel Matrix (Absolute Values)
figure;
imagesc(abs(H));
colorbar;
title('Channel Matrix H (Absolute Values)');
xlabel('Transmit Antennas');
ylabel('Receive Antennas');


% BER vs SNR
SNR_range = 0:0.001:15; % SNR values from 0 to 30 dB in steps of 2 dB
BER = zeros(1, length(SNR_range)); % Preallocate BER array
signalPower = var(s); % calculate signal power

for i = 1:length(SNR_range)
    % Compute the noise variance from the SNR
    SNR_linear = 10^(SNR_range(i) / 10);
    noiseVar = signalPower / SNR_linear;
    noise = sqrt(noiseVar / 2) * (randn(Nr, 1) + 1i * randn(Nr, 1));
    
    % Received signal
    y = H * s + noise;
    
    % ZF detection
    sHat = (H'*H)\(H'*y);
    
    % Decode the signals
    decodedSignal = real(sHat) > 0;
    
    % Calculate BER
    errors = sum(txSignal ~= decodedSignal);
    BER(i) = errors / Nt;
end

% Plot BER vs SNR
figure;
semilogy(SNR_range, BER, 'b*');
grid on;
title('BER vs SNR for 8x8 MIMO System (ZF Detection)');
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');


% Calculate Spectral Efficiency
spectral_efficiency = min(Nt, Nr); % For BPSK and all streams used
disp("Spectral Efficiency (in bits/s/Hz):");
disp(spectral_efficiency);
