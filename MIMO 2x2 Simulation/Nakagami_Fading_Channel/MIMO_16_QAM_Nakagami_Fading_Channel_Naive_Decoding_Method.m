% Number of transmitter and receiver antennas
Nt = 2;
Nr = 2;

% Number of data symbols
Ndata = 10^4;

% Noise power
N0 = 0.01;

% Constellation size for 16-QAM
M = 16;

% MIMO Channel

% The channel is a Nr x Nt matrix for each symbol

H = (randn(Nr,Nt,Ndata) + 1i*randn(Nr,Nt,Ndata))/sqrt(2);

% Generate random 16-QAM symbols

modulator = comm.RectangularQAMModulator('ModulationOrder', M, 'BitInput', true);
bitsPerSymbol = log2(M);
data = randi([0 1], Nt, bitsPerSymbol * Ndata);
dataReshaped = reshape(data, [], 1);
dataModulated = modulator(dataReshaped);

% Reshape dataModulated to match the shape of data
dataModulated = reshape(dataModulated, Nt, []);

x = zeros(Nr, Ndata);
for i = 1:Ndata
    x(:,i) = H(:,:,i)*dataModulated(:,i);
end



% Nakagami Fading
m = 1; % fading parameter
Omega = 1; % spread parameter
g = m/Omega*abs(gamrnd(m,Omega,Nr,Nt,Ndata)).^2; % gamma distribution
H = H.*sqrt(g); % apply Nakagami fading

% Transmitted Signal
x = zeros(Nr, Ndata);
for i = 1:Ndata
    x(:,i) = H(:,:,i)*dataModulated(:,i);
end

% Noise
noise = sqrt(N0/2)*(randn(Nr,Ndata) + 1i*randn(Nr,Ndata));

% Received Signal
y = x + noise;

% Zero-Forcing Receiver
% Zero-Forcing Receiver
demodulator = comm.RectangularQAMDemodulator('ModulationOrder', M, 'BitOutput', true);
decoded_data = zeros(bitsPerSymbol*Nt, Ndata);
for i = 1:Ndata
    y_reshaped = reshape(y(:,i), [], 1);
    decoded_data_reshaped = demodulator(pinv(H(:,:,i))*y_reshaped); % QPSK decoding
    decoded_data(:,i) = decoded_data_reshaped;
end
decoded_data = reshape(decoded_data, size(data));



% Check bit error rate
ber = sum(sum(data ~= decoded_data))/(Nt*bitsPerSymbol*Ndata);
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
refSignal = dataModulated; % Reference signal, which is our original data
refSignal1D = reshape(refSignal, 1, []);
refSignal1D = refSignal1D';
decoded_dataReshaped = reshape(decoded_data, [], 1);
decoded_dataModulated = modulator(decoded_dataReshaped);
decoded_data1D = reshape(decoded_dataModulated, 1, []);
decoded_data1D = decoded_data1D';
evm = comm.EVM('ReferenceSignalSource','Input port');
errorVectorMagnitude = evm(refSignal1D, decoded_data1D);
fprintf('Error Vector Magnitude = %f %%\n', errorVectorMagnitude);

% Spectral Efficiency

spectralEfficiency = bitsPerSymbol / Ts;
fprintf('Spectral Efficiency = %f bps/Hz\n', spectralEfficiency);

% Channel Capacity
EbNo = 10*log10(signalPower/noisePower); % SNR per bit
noisePower = 10^(-EbNo/10);
capacity = log2(1 + (signalPower/noisePower));
fprintf('Channel Capacity = %f bps/Hz\n', capacity);
