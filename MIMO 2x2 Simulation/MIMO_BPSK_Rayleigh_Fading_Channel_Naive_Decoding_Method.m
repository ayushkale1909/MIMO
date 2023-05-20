% Parameters
N = 1e5; % Number of bits to transmit
M = 2;  % Modulation order (BPSK)
k = log2(M); % Number of bits per symbol
Ts = 1e-6; % symbol period in seconds, adjust based on your requirements

% Initialize
H = (randn(2,2) + 1j*randn(2,2))/sqrt(2); % Rayleigh MIMO channel
x = randi([0 1],N*k,1); % Information bits

modSignal = pskmod(x,M); % BPSK modulation
modSignal = reshape(modSignal,[],2); % Convert to 2x2 MIMO

% MIMO Transmission
y = H*modSignal.'; % MIMO channel

% Add Noise 
EbNo = 10; % Eb/No in dB, adjust based on your requirements
snr = EbNo + 10*log10(k); % SNR
yNoisy = awgn(y, snr, 'measured'); % Add AWGN

% MIMO Reception
yNoisy = yNoisy.'; % Transpose for correct dimension
receivedSignal = H\yNoisy.'; % Inverse channel

% Demodulate
receivedSignal = receivedSignal(:); % Convert back to column vector
receivedBits = pskdemod(receivedSignal,M);

% Error rate calculation
[number,ratio] = biterr(x,receivedBits);
fprintf('Bit error ratio = %f\n', ratio);

% SNR Calculation
signalPower = mean(abs(receivedSignal).^2);
noisePower = mean(abs(receivedSignal - yNoisy(:)).^2);
estimatedSNR = 10*log10(signalPower/noisePower);
fprintf('Estimated SNR = %f dB\n', estimatedSNR);

% Throughput
throughput = N / (Ts * length(modSignal(:)));
fprintf('Throughput = %f bps\n', throughput);

% EVM Calculation
refSignal = pskmod(x,M); % Reference signal
evm = comm.EVM('ReferenceSignalSource','Input port');
errorVectorMagnitude = evm(refSignal, receivedSignal);
fprintf('Error Vector Magnitude = %f %%\n', errorVectorMagnitude);

% Spectral Efficiency
spectralEfficiency = log2(M) / Ts;
fprintf('Spectral Efficiency = %f bps/Hz\n', spectralEfficiency);

% Channel Capacity
noisePower = 10^((-EbNo)/10);
capacity = log2(1 + (1/noisePower));
fprintf('Channel Capacity = %f bps/Hz\n', capacity);
