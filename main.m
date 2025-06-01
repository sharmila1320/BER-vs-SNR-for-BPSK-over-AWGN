% BER vs SNR for BPSK over AWGN
clc; clear;

N = 1e5;  % Number of bits
SNR_dB = 0:1:10;  % SNR range in dB
BER_sim = zeros(size(SNR_dB));

% Generate random bits
bits = randi([0 1], 1, N);
symbols = 2*bits - 1;  % BPSK modulation: 0 -> -1, 1 -> +1

for i = 1:length(SNR_dB)
    snr = 10^(SNR_dB(i)/10);
    noise = randn(1, N) / sqrt(2*snr);  % AWGN
    received = symbols + noise;
    
    detected_bits = received > 0;
    errors = sum(bits ~= detected_bits);
    BER_sim(i) = errors / N;
end

% Theoretical BER
BER_theory = qfunc(sqrt(2 * 10.^(SNR_dB / 10)));

% Plot
figure;
semilogy(SNR_dB, BER_sim, 'bo-', SNR_dB, BER_theory, 'r*-');
grid on;
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
title('BER vs SNR for BPSK over AWGN');
legend('Simulated BER', 'Theoretical BER');
