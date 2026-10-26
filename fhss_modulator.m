function [tx,phase,carrier] = fhss_modulator(nrz,hopFreq,cfg)
% Real carrier modulation with continuous phase through hop transitions.
n = numel(nrz);
if numel(hopFreq) ~= n, error('NRZ and hop sequence lengths differ.'); end
phase = zeros(1,n);
if n>1, phase(2:end) = 2*pi/cfg.Fs*cumsum(hopFreq(1:end-1)); end
carrier = cfg.carrierAmplitude*cos(phase);
tx = nrz.*carrier;
end
