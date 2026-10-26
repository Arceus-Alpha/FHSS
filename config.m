function cfg = config()
% End-to-end Stage 1 FHSS demo: rectangular NRZ BPSK, real carrier, AWGN only.
cfg.Rb = 100;
cfg.Tb = 1/cfg.Rb;
cfg.Fs = 10000;
cfg.sps = round(cfg.Fs/cfg.Rb);
cfg.hopFrequencies = [100 200 300 400];
cfg.sfDwellBits = 4;             % SFHSS: one hop per 4 bits
cfg.ffDwellFraction = 0.25;      % FFHSS: four hops per bit
cfg.messageEbN0dB = 12;
cfg.berNumBits = 200000;
cfg.EbN0dB = 0:2:12;
cfg.Eb = 1;
cfg.carrierAmplitude = sqrt(2/cfg.Tb);
cfg.hopSeed = 1234;
cfg.noiseSeed = 9876;
cfg.message = 'FHSS MESSAGE RECONSTRUCTION';
end
