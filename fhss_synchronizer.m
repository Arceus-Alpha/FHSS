function phaseHat = fhss_synchronizer(hopFreq,cfg)
% Ideal receiver synchronization: exact hop pattern and initial phase.
n = numel(hopFreq);
phaseHat = zeros(1,n);
if n>1, phaseHat(2:end) = 2*pi/cfg.Fs*cumsum(hopFreq(1:end-1)); end
end
