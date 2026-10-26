function [nrz, symbols] = bpsk_transmitter(bits,cfg)
% Rectangular polar NRZ: bit 1 -> +1; bit 0 -> -1. No pulse shaping.
symbols = 2*double(bits)-1;
nrz = repelem(symbols,cfg.sps);
end
