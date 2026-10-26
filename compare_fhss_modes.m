function results = compare_fhss_modes(cfg)
% BER sweep for both hopping modes, independent of the text demonstration.
rng(2468,'twister');
bits = randi([0 1],1,cfg.berNumBits);
[nrz,~] = bpsk_transmitter(bits,cfg);
modes={'SFHSS','FFHSS'};
results.modes=modes; results.EbN0dB=cfg.EbN0dB;
results.ber=zeros(2,numel(cfg.EbN0dB)); results.errors=zeros(2,numel(cfg.EbN0dB));
for m=1:2
    [hf,~,~]=generate_hopping_sequence(cfg,modes{m},numel(bits),m);
    [tx,~,~]=fhss_modulator(nrz,hf,cfg);
    ph=fhss_synchronizer(hf,cfg);
    for k=1:numel(cfg.EbN0dB)
        rx=channel_model(tx,cfg.EbN0dB(k),cfg,100*m+k);
        corr=rx.*(cfg.carrierAmplitude*cos(ph));
        bhat=bpsk_receiver(corr,ph,cfg);
        [results.ber(m,k),results.errors(m,k)]=calculate_ber(bits,bhat);
    end
end
results.theory=0.5*erfc(sqrt(10.^(cfg.EbN0dB/10)));
end
