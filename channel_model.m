function [rx,noise] = channel_model(tx,EbN0dB,cfg,seedOffset)
% Real AWGN channel; no interference or multipath.
if nargin<4, seedOffset=0; end
gamma = 10^(EbN0dB/10);
N0 = cfg.Eb/gamma;
noiseVariance = N0*cfg.Fs/2;
rng(cfg.noiseSeed+seedOffset,'twister');
noise = sqrt(noiseVariance)*randn(size(tx));
rx = tx+noise;
end
