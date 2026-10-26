% End-to-end FHSS demonstration for both SFHSS and FFHSS.
clear; clc; close all;
cfg=config();
fprintf('Rb = %.0f bit/s, Fs = %.0f samples/s, sps = %d\n',cfg.Rb,cfg.Fs,cfg.sps);
fprintf('Carrier amplitude sqrt(2/Tb) = %.4f\n',cfg.carrierAmplitude);
fprintf('Hop frequencies (kHz): '); fprintf('%.1f ',cfg.hopFrequencies/1e3); fprintf('\n');

fprintf('\nOriginal text: %s\n',cfg.message);

txSF=transmit_message(cfg.message,cfg,'SFHSS',10);
rxSF=receive_message(txSF,cfg.messageEbN0dB,cfg,11);

txFF=transmit_message(cfg.message,cfg,'FFHSS',20);
rxFF=receive_message(txFF,cfg.messageEbN0dB,cfg,21);

fprintf('\nSFHSS\n');
fprintf('Reconstructed: %s\n',rxSF.message);
fprintf('Errors: %d/%d, BER = %.6g at Eb/N0 = %.1f dB\n',rxSF.nErr,txSF.numBits,rxSF.ber,rxSF.EbN0dB);
fprintf('Exact message match: %s\n',yesno(strcmp(rxSF.message,cfg.message)));

fprintf('\nFFHSS\n');
fprintf('Reconstructed: %s\n',rxFF.message);
fprintf('Errors: %d/%d, BER = %.6g at Eb/N0 = %.1f dB\n',rxFF.nErr,txFF.numBits,rxFF.ber,rxFF.EbN0dB);
fprintf('Exact message match: %s\n',yesno(strcmp(rxFF.message,cfg.message)));

fprintf('\nGenerating BER curves for both hopping modes...\n');
results=compare_fhss_modes(cfg);
fprintf('Eb/N0(dB) | SFHSS BER | FFHSS BER | Theory\n');
for k=1:numel(cfg.EbN0dB)
    fprintf('%8.1f | %.5g | %.5g | %.5g\n',cfg.EbN0dB(k), ...
        results.ber(1,k),results.ber(2,k),results.theory(k));
end

plot_results(results,cfg,txSF,rxSF,txFF,rxFF);
fprintf('\nDone. Separate figures show complete SFHSS and FFHSS paths.\n');

function s=yesno(v)
if v, s='YES'; else, s='NO'; end
end
