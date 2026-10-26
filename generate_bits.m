function bits = generate_bits(cfg)
% GENERATE_BITS Generate reproducible random bits for BER testing.
rng(cfg.bitSeed, 'twister');
bits = randi([0 1], 1, cfg.berNumBits);
end
