function d = transmit_message(message,cfg,mode,seedOffset)
% Complete text transmitter.
if nargin<4, seedOffset=0; end
bits = message_to_bits(message);
[nrz,symbols] = bpsk_transmitter(bits,cfg);
[hopFreq,hopIndex,hopSamples] = generate_hopping_sequence(cfg,mode,numel(bits),seedOffset);
[tx,phase,carrier] = fhss_modulator(nrz,hopFreq,cfg);
d.message=message; d.bits=bits; d.symbols=symbols; d.nrz=nrz;
d.hopFreq=hopFreq; d.hopIndex=hopIndex; d.hopSamples=hopSamples;
d.tx=tx; d.phase=phase; d.carrier=carrier; d.mode=upper(mode);
d.numBits=numel(bits);
end
