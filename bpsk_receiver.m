function [detectedBits,decisionStatistic] = bpsk_receiver(correlationInput,phaseHat,cfg)
% Integrate-and-dump coherent detector. Correctly uses carrier-template energy.
nBits = floor(numel(correlationInput)/cfg.sps);
n = nBits*cfg.sps;
x = reshape(correlationInput(1:n),cfg.sps,nBits);
basis = cfg.carrierAmplitude*cos(phaseHat(1:n));
basis = reshape(basis,cfg.sps,nBits);
dt = 1/cfg.Fs;
corr = sum(x,1)*dt;
energy = sum(basis.^2,1)*dt;
decisionStatistic = corr./max(energy,eps);
detectedBits = double(decisionStatistic>=0);
end
