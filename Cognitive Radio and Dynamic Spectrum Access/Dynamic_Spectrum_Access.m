frequencies = [2.4e9, 2.5e9, 2.6e9, 2.7e9, 2.8e9];  % Example 
currentFrequency = frequencies(1); 

for i = 1:length(frequencies)
    txSignal = qammod(data, M, 'InputType', 'bit', 'UnitAveragePower', true);
    rxSignal = awgn(txSignal, SNR);  % Received signal 
    
    % Spectrum Sensing
    energy = abs(rxSignal).^2;
    
    if mean(energy) > threshold  % If primary user is detected
        if i == length(frequencies)  % If all frequencies have been used
            error('No free frequencies available');
        else
            currentFrequency = frequencies(i+1);  % Next frequency
        end
    else  % If no primary user is detected
        disp('Spectrum hole detected, continuing transmission');
        break;
    end
end
