
% Number of transmitter and receiver antennas
Nt = 2;
Nr = 2;

% Number of data symbols
Ndata = 10^4;

% Noise power
N0 = 0.01;

% Generate random BPSK symbols
data = 2*randi([0 1],Nt,Ndata) - 1;

% MIMO Channel
% The channel is a Nr x Nt matrix for each symbol
H = (randn(Nr,Nt,Ndata) + 1i*randn(Nr,Nt,Ndata))/sqrt(2);

% Nakagami Fading
m = 1; % fading parameter
Omega = 1; % spread parameter
g = m/Omega*abs(gamrnd(m,Omega,Nr,Nt,Ndata)).^2; % gamma distribution
H = H.*sqrt(g); % apply Nakagami fading

% Transmitted Signal
x = zeros(Nr, Ndata);
for i = 1:Ndata
    x(:,i) = H(:,:,i)*data(:,i);
end

% Noise
noise = sqrt(N0/2)*(randn(Nr,Ndata) + 1i*randn(Nr,Ndata));

% Received Signal
y = x + noise;

% Zero-Forcing Receiver
decoded_data = zeros(Nt, Ndata);
for i = 1:Ndata
    decoded_data(:,i) = sign(real(pinv(H(:,:,i))*y(:,i))); % BPSK decoding
end

% Check bit error rate
ber = sum(sum(data ~= decoded_data))/(Nt*Ndata);
disp(['Bit error rate: ', num2str(ber)]);

% SNR Calculation
signalPower = mean(abs(x).^2, 'all');
noisePower = mean(abs(noise).^2, 'all');
estimatedSNR = 10*log10(signalPower/noisePower);
fprintf('Estimated SNR = %f dB\n', estimatedSNR);

% Throughput
Ts = 1; % Symbol time, set according to your system
throughput = Ndata / (Ts * Ndata); % Here Ndata = length(data)
fprintf('Throughput = %f bps\n', throughput);

% EVM Calculation
refSignal = data; % Reference signal, which is our original data
refSignal1D = reshape(refSignal, 1, []);
refSignal1D = refSignal1D';
decoded_data1D = reshape(decoded_data, 1, []);
decoded_data1D = decoded_data1D';
evm = comm.EVM('ReferenceSignalSource','Input port');
errorVectorMagnitude = evm(refSignal1D, decoded_data1D);
fprintf('Error Vector Magnitude = %f %%\n', errorVectorMagnitude);

% Spectral Efficiency
% As we use BPSK, the spectral efficiency is 1 bit per symbol
spectralEfficiency = 1 / Ts;
fprintf('Spectral Efficiency = %f bps/Hz\n', spectralEfficiency);

% Channel Capacity
EbNo = 10*log10(signalPower/noisePower); % SNR per bit
noisePower = 10^(-EbNo/10);
capacity = log2(1 + (signalPower/noisePower));
fprintf('Channel Capacity = %f bps/Hz\n', capacity);

