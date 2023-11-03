clc;
clear all;
close all;
% Parameters
num_bits = 1000;  % Number of random binary bits
EbNo_dB = 0:2:20;  % Range of Eb/No values in dB

% Initialize variables to store error rates
bit_error_rate = zeros(1, length(EbNo_dB));
symbol_error_rate = zeros(1, length(EbNo_dB));

for snr_index = 1:length(EbNo_dB)
    % Step 1: Generation of random binary sequence
    input_bits = randi([0, 1], 1, num_bits);
    
    % Step 2: BPSK modulation
    modulated_symbols = 2 * input_bits - 1;  % 0 maps to -1, 1 maps to 1
    
    % Step 3: Convolution with a 3-tap filter (if needed)
    % Not explicitly implemented in this example
    
    % Step 4: Adding White Gaussian Noise
    EbNo = 10^(EbNo_dB(snr_index) / 10);  % Convert dB to linear scale
    noise_variance = 1 / (2 * EbNo);  % For BPSK modulation
    noise = sqrt(noise_variance) * randn(1, num_bits);
    received_symbols = modulated_symbols + noise;
    
    % Step 5: Demodulation and conversion to bits
    demodulated_bits = received_symbols > 0;
    
    % Step 6: Counting the number of bit errors
    bit_errors = sum(demodulated_bits ~= input_bits);
    
    % Calculate symbol errors (if needed)
    symbol_errors = sum(demodulated_bits ~= modulated_symbols);
    
    % Step 7: Store error rates
    bit_error_rate(snr_index) = bit_errors / num_bits;
    symbol_error_rate(snr_index) = symbol_errors / num_bits;
end

% Step 8: Display results
semilogy(EbNo_dB, bit_error_rate, 'bo-');
grid on;
xlabel('Eb/No (dB)');
ylabel('Bit Error Rate');
