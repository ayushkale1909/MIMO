# -*- coding: utf-8 -*-
"""PPM.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1wANxifKQgUX65r7ywX5hIymd1KR-ib0z
"""

import numpy as np
import matplotlib.pyplot as plt

# Binary Data
data = np.array([0, 1, 0, 1, 1, 0, 1])

# Parameters
num_bits = len(data)  # Number of bits
Ts = 1  # Symbol period
Fs = 100  # Sampling frequency 
t = np.linspace(0, Ts, Fs, endpoint=False)  # Time

# PPM Modulation
ppm = np.zeros((num_bits, Fs))  # Initialization
for i in range(num_bits):
    if data[i] == 1:
        ppm[i, int(Fs/4):int(Fs/2)] = 1  # If value is 1, place pulse in first half of period

# Plot
plt.figure(figsize=(10,5))
plt.plot(ppm.flatten(), 'b')
plt.yticks([0, 1], ['0', '1'])
plt.grid(True)
plt.show()

# PPM Demodulation
demodulated_data = np.zeros(num_bits)
for i in range(num_bits):
    if np.sum(ppm[i, int(Fs/4):int(Fs/2)]) > 0:
        demodulated_data[i] = 1
    else:
        demodulated_data[i] = 0

# Print Results
print('Original Data: ', data)
print('Demodulated Data: ', demodulated_data)