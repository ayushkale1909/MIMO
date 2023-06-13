# MIMO Channel-Coded OFDM System Simulation
This simulation presents the evaluation of a 2x2 and an 8x8 MIMO system with various modulation schemes, channel models, decoding methods, and performance measures.

## Modulation Schemes
The simulation includes the following modulation schemes:

16-QAM
64-QAM
256-QAM
BPSK
QPSK
Channel Models
The simulation features these channel models:

Random Flat Fading Channel
Rayleigh Fading Channel
Nakagami Fading Channel
Communication System
A convolutional encoder and a Viterbi decoder are used to encode and decode the transmitted data. The performance is measured by evaluating the error rate in the presence of noise.

## 8x8 MIMO System
The simulation includes an 8x8 MIMO system employing spatial multiplexing. The performance is evaluated in terms of BER, SNR, and spectral efficiency. Zero-forcing detection is utilized, with plots of the transmitted and received signals, the channel matrix, and the BER vs. SNR curve included.

## 2x2 MIMO Spatial Multiplexing
This simulation features a 2x2 MIMO system with spatial multiplexing. The Binary Phase Shift Keying (BPSK) modulation scheme is used under an Additive White Gaussian Noise (AWGN) channel model with Rayleigh fading. The BER under various SNRs is used to evaluate the system's performance.

## Visible Light Communication Systems
Simulation of commonly used modulation schemes in the context of visible light communication systems:

1. Pulse Position Modulation (PPM)  
2. Pulse Amplitude Modulation 
3. OFDM (assuming no data loss and noise)

The code includes plots of the transmitted signal, modulation and demodulation of the binary signal used, and a comparison of original and received signals.

## Cognitive Radio System
In the context of a cognitive radio system, a Quadrature Amplitude Modulation (QAM) signal with noise is used for energy detection and spectrum sensing. An arbitrary threshold determines the presence of a primary user. It calculates the probability of detection for different threshold and SNR values, and plots this probability as a function of detection threshold and SNR.

## Dynamic Spectrum Access
The simulation of a dynamic spectrum access system iterates over a list of frequencies, switching its operating frequency based on the presence of primary users:

1. If a primary user is detected at the current frequency, the system switches to the next frequency in the list.
2. If a primary user is detected at all frequencies, the system throws an error.
3. If no primary user is detected at the current frequency, the system identifies it as a spectrum hole and continues transmission at this frequency.

