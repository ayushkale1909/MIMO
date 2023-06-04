# MIMO
Channel-Coded MIMO-OFDM System Simulation


1. Simulation of 2x2 MIMO System with different modulation schemes, Channel Models and Decoding Methods: 
        
        Modulation Schemes 
          1. 16-QAM
          2. 64-QAM 
          3. 256-QAM
          4. BPSK 
          5. QPSK
        
        Channel Models 
          1. Random Flat Fading Channel 
          2. Rayleigh Fading Channel 
          3. Nakagami Fading Channel 

2. Simulation of communication system utilizing convolutional encoder and a Viterbi decoder to encode and decode the transmitted data, respectively. Evaluating its      performance by measuring the error rate in the presence of noise.

3. Simulation of an 8x8 MIMO system using spatial multiplexing. Evaluating the performance of the system in terms of BER and SNR, and spectral efficiency. Utilizing    zero-forcing detection and plots of the transmitted and received signals, the channel matrix, and the BER vs. SNR curve.

2x2 MIMO Spatial Multiplexing Simulation with BPSK and Zero-Forcing Equalization

    Spatial Multiplexing MATLAB code contains simulation of 2x2 MIMO system with spatial multiplexing. 
    The channel uses  Binary Phase Shift Keying (BPSK) as the modulation scheme in the simulation and 
    the channel is Additive White Gaussian Noise (AWGN) channel model with Rayleigh fading. The BER with 
    various SNRs is used to evaluate this system's performance.


Simulation of Commonly used modulation schemes in the context of Visible Light Communication Systems.   

        1. Pulse Position Modulation (PPM)  
        2. Pulse Amplitude Modulation 
        3. OFDM. No loss of data and noise is assumed. 

The code contains plotting of the transmitted signal , Modulation and Demodulation of the binary signal used 
and Comparision of  original and recevied signals. 


Cognitive Radio System Simulation

        Quadrature Amplitude Modulation (QAM) signal with noise is used for energy detection and spectrum sensing. Uses an arbitrary threshold  to determine the           presence of a primary user. . It calculates the probability of detection for different threshold values and SNR values and then plots this probability as         a function of the detection threshold and SNR.   
        
Dynamic Spectrum Access

        Simulation a dynamic spectrum access system, where it iterates over a list of frequencies and switches its operating frequency based on the presence of           primary users.
        1. If a primary user is detected at the current frequency, the system switches to the next frequency in the list. 
        2. If a primary user is detected at all frequencies, the system throws an error.
        3.  If no primary user is detected at the current frequency, the system identifies it as a spectrum hole and continues transmission at this frequency.
        
       
