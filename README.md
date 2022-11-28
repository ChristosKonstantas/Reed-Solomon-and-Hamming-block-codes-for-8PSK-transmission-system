# Reed-Solomon-and-Hamming-block-codes-for-8PSK-transmission-system
Ιmplementation of Hamming and Reed-Solomon block encoders and decoders to a transmission system with 8PSK modulation.

The purpose of the exercise is to estimate the probability of error (BER).
It is the comparison of the above two coding methods with each other and with the method of
direct transmission without coding.
For each SNR per (info) bit value in dB, perform the following steps:
1. Assuming that the additive Gaussian noise of the transmission channel has
dispersion 1, calculate the energy E per info bit in linear value.

2. Create a vector b with M equal bits, using the function
randi.m. In order not to have problems with the groupings that will follow, the
M must be a multiple of 3, 4, ̹and 5 (indicatively, M = 3 · 104).

3. Serially read the triplets from b and using the function gray2bi.m
create the corresponding vector b_gray of length M. The triples of the vector
b_gray will be sent unencoded or Reed-Solomon encoded.

4. Compute the octal symbols (0,1,. . . ,7) to which the triplets of bits correspond
by b_gray.

5. For the case of no coding, the above symbols are reduced to 8
corresponding phases of the modulator constellation, are amplified with the appropriate one
parameter (based on E per info bit - not symbol, caution here), and are transmitted in
from the channel. The 8 symbols of the constellation (before the transmitter amplifier) are e^(j2πi/8), i = 0, 1, . . . , 7.

6. For the case of Reed-Solomon modulation with l = 3, K = 5, N = 7 and transmission rate R = K/N = 5/7. The above symbols of step 4 are grouped into fives
̹and are mapped to heptad codes from octal symbols using the
codebook which is stored in the Reed_Solomon_Codebook sizes table
8^5 × 7. Next, the coded symbols are 8PSK modulated and transmitted similarly to step 5. Be careful with the gain factor, because
encoding is different than before.

7. For the case of Hamming modulation with m = 3, k = 4, n = 7, and rate R = k / n = 4/7, the bits of b of step 2 are grouped into quadruplets and assigned
into code heptads of bits using the codebook of size 2^4 × 7 which
we constructed in the corresponding lecture of the course. The resulting bit stream (of length Mn/k) is read serially in triplets, each triplet is converted into a Gray (via gray2bi.m) as in step 3, for the resulting Gray triples
we calculate the corresponding octal symbols similar to step 4, and finally
we modulate and transmit these octal symbols with 8PSK as in step 5. Again, be careful with the gain factor, it is different.

8. In all three transmission cases, the channel adds complex Gaussian noise of mean 0 and variance 1.

9. For the non-coding case, in the receiver use the ML detector which has the form x = argmax {xi{Re{x* · y}}}. Next, get rid of it
Gray display via bi2gray.m function. Finally, calculate the number of
errors made by the receiver in the info bits.

10. For the case of Reed-Solomon coding, repeat the procedure of the previous step with the difference that instead of symbol-by-symbol ML detection you will implement block-by-block soft-decision decoding of the form xˆ = argmax {xi Re{c (xi) H · y}},
where each block c(xi) contains N = 7 received 8PSK symbols and corresponds to K = 5 info symbols contained in xi.

11. For the case of Hamming coding, start with ML decoding and elimination of the Gray representation as in step 9 and follow with block-by-block hard-decision decoding, where each block contains n = 7 coded bits and corresponds to k = 4 info bits.
Repeat the above steps for values ​​of SNR per bit from 0dB to 14dB.
