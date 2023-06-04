threshold_values = 0:2:20;  % Threshold values
prob_detection = zeros(size(threshold_values));  % Probability

for i = 1:length(threshold_values)
    % Energy Detection
    energy = abs(rxSignal).^2;

    % Detection 
    detection = mean(energy) > threshold_values(i);

    prob_detection(i) = mean(detection);
end

% Plot
plot(threshold_values, prob_detection);
xlabel('Detection Threshold');
ylabel('Probability of Detection');
title('Sensing Performance vs Detection Threshold');
