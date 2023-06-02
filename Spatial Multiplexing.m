
% Define parameters
Nt = 2; % number of transmit antennas
Nr = 2; % number of receive antennas
EsNo_dB = 0:25; % SNR per bit 
iters = 10000; % number of iterations

% Define BPSK modulation 
modObj = comm.BPSKModulator();

% Define AWGN channel
chanObj = comm.AWGNChannel('NoiseMethod', 'Signal to noise ratio (Es/No)', 'SignalPower', 1);

% Define error rate 
errObj = comm.ErrorRate();

for idx = 1:length(EsNo_dB)
    for jdx = 1:iters
        % Generate random bits
        bits = randi([0 1], Nt, 1);

        % Modulatation
        modSig = step(modObj, bits);

        % Generate channel matrix
        H = (1/sqrt(2*Nt))*(randn(Nr, Nt) + 1j*randn(Nr, Nt));

        % Transmit through the channel with noise 
        chanObj.EsNo = EsNo_dB(idx);
        recvSig = step(chanObj, H*modSig);

        % Zero forcing equalization
        equalizedSig = inv(H'*H)*H'*recvSig;

        % Demodulation
        demodSig = double(real(equalizedSig) > 0);

        % Error rate
        err = step(errObj, bits, demodSig);
    end

    
    ber(idx) = err(1);
end

% Plot BER vs Es/No
figure;
semilogy(EsNo_dB, ber);
grid on;
xlabel('Es/No (dB)');
ylabel('BER');
title('BER vs Es/No for 2x2 MIMO');
