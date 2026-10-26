FHSS Project with detailed plots for both SFHSS and FFHSS

Run main.m from this folder.

Each mode gets its own six-panel figure:
1. Original message bits (0/1)
2. Pseudorandom hopping-frequency sequence
3. Transmitted real passband signal
4. Received signal with AWGN
5. Dehopped/recovered baseband versus original NRZ
6. Original and detected bits plus reconstructed message in title

A separate figure compares SFHSS and FFHSS BER versus Eb/N0 and theoretical
coherent BPSK. System assumptions: rectangular polar NRZ, no pulse shaping,
real carrier amplitude sqrt(2/Tb), AWGN only, perfect synchronization.

Message is 8-bit ASCII. Set cfg.message in config.m to a different ASCII string.
Set cfg.messageEbN0dB to control the noise level for the text demonstration.
