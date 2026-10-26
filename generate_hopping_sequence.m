function [hopFreq, hopIndex, hopSamples] = generate_hopping_sequence(cfg,mode,numBits,seedOffset)
% Reproducible pseudorandom hop pattern, one hop frequency per sample.
if nargin < 3 || isempty(numBits), numBits = ceil(numel(cfg.message)*8); end
if nargin < 4, seedOffset = 0; end
switch upper(mode)
    case 'SFHSS'
        hopSamples = cfg.sfDwellBits*cfg.sps;
    case 'FFHSS'
        hopSamples = max(1,round(cfg.ffDwellFraction*cfg.sps));
    otherwise
        error('Mode must be SFHSS or FFHSS.');
end
n = numBits*cfg.sps;
rng(cfg.hopSeed+seedOffset,'twister');
hopList = randi(numel(cfg.hopFrequencies),1,ceil(n/hopSamples));
hopIndex = repelem(hopList,hopSamples);
hopIndex = hopIndex(1:n);
hopFreq = cfg.hopFrequencies(hopIndex);
end
