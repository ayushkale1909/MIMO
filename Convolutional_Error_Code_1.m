% Define parameters
N = 1e5;   % Number of bits to transmit
EbNo = 5;  % Eb/No value

% Convolutional Encoder System object
convEncoder = comm.ConvolutionalEncoder(poly2trellis(7, [171 133]));

% Error probability for Binary Symmetric Channel
probability = 0.01;

% Traceback depth
tb_depth = 5*7;

% Viterbi Decoder System object
viterbiDecoder = comm.ViterbiDecoder(poly2trellis(7, [171 133]), 'InputFormat', 'Hard', 'TracebackDepth', tb_depth, 'TerminationMethod', 'Terminated');

% Error Rate Calculation System object
errorCalc = comm.ErrorRate;

% L, as the largest number <= N 
% multiple of the traceback depth
L = tb_depth * floor(N/tb_depth);

% Main loop
for counter = 1:10
    % Generate data
    data = [randi([0 1], L, 1); zeros(tb_depth,1)];  % Append zeros equal to the traceback depth for K=7

    % Encode data
    encData = convEncoder(data);

    % Noisy channel
    receivedData = bsc(encData, probability);

    % Decode received data
    decData = viterbiDecoder(receivedData);

    % Error statistics
    errorStats = errorCalc(data(1:L), decData(1:L));  % Compare L bits
    
    

end

% Display results
fprintf('\nError rate = %f\nNumber of errors = %d\n', errorStats(1), errorStats(2))
