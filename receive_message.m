function d = receive_message(txData,EbN0dB,cfg,noiseSeedOffset)
% Complete synchronized receiver and text reconstruction.
if nargin<4, noiseSeedOffset=0; end
[rx,noise] = channel_model(txData.tx,EbN0dB,cfg,noiseSeedOffset);
phaseHat = fhss_synchronizer(txData.hopFreq,cfg);
localCarrier = cfg.carrierAmplitude*cos(phaseHat);
correlationInput = rx.*localCarrier;
[bitsHat,decision] = bpsk_receiver(correlationInput,phaseHat,cfg);
messageHat = bits_to_message(bitsHat);

% Display a stable integrate-and-dump baseband estimate per bit.
% This avoids dividing sample-by-sample by cos(phase), which is unstable
% near carrier zero crossings.
dehopped = repelem(decision,cfg.sps);

d.rx=rx; d.noise=noise; d.phaseHat=phaseHat;
d.dehopped=dehopped; d.correlationInput=correlationInput;
d.bits=bitsHat; d.decision=decision; d.message=messageHat;
d.ber=sum(txData.bits(1:numel(bitsHat))~=bitsHat)/numel(bitsHat);
d.nErr=sum(txData.bits(1:numel(bitsHat))~=bitsHat);
d.EbN0dB=EbN0dB;
end
