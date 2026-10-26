function plot_results(results, cfg, txSF, rxSF, txFF, rxFF)
% PLOT_RESULTS
% Figure 1: SFHSS transmission and reception
% Figure 2: FFHSS transmission and reception
% Figure 3: Message reconstruction and BER comparison
%
% Figure 3 compares binary message bits (0 and 1).
% Received waveforms are hidden when Eb/N0 >= 12 dB.

%% VALIDATE RECONSTRUCTED BIT DATA
if ~isfield(rxSF, 'bits') || ~isfield(rxFF, 'bits')
    error(['Reconstructed bit arrays are missing. Update bpsk_receiver.m ' ...
        'to return detected bits in rx.bits. Do not use rx.message if ' ...
        'it contains a descriptive text label.']);
end

originalBitsSF = double(txSF.bits(:).');
recoveredBitsSF = double(rxSF.bits(:).');

originalBitsFF = double(txFF.bits(:).');
recoveredBitsFF = double(rxFF.bits(:).');

validate_bits(originalBitsSF, 'SFHSS original');
validate_bits(recoveredBitsSF, 'SFHSS reconstructed');
validate_bits(originalBitsFF, 'FFHSS original');
validate_bits(recoveredBitsFF, 'FFHSS reconstructed');

%% FIGURE 1: SFHSS TRANSMISSION AND RECEPTION
figure(1);
clf;
set(gcf, 'Name', 'SFHSS Transmission and Reception', 'Color', 'w');

nShowBitsSF = min([64, numel(originalBitsSF), txSF.numBits]);
nShowSF = min([nShowBitsSF * cfg.sps, ...
    numel(txSF.tx), numel(rxSF.rx), numel(txSF.hopFreq)]);

tSF = (0:nShowSF-1) / cfg.Fs;

% Plot 1: Original message bits
subplot(3,1,1);
stairs(0:nShowBitsSF-1, originalBitsSF(1:nShowBitsSF), ...
    'LineWidth', 1.2);
ylim([-0.2 1.2]);
xlim([0 max(1,nShowBitsSF-1)]);
yticks([0 1]);
grid on;
xlabel('Bit Index');
ylabel('Bit Value');
title('SFHSS: Original Message Bits');

% Plot 2: SFHSS hopping-frequency sequence
subplot(3,1,2);
stairs(tSF, txSF.hopFreq(1:nShowSF)/1e3, ...
    'LineWidth', 1.1);
grid on;
if nShowSF > 1
    xlim([tSF(1) tSF(end)]);
end
xlabel('Time (s)');
ylabel('Frequency (kHz)');
title('SFHSS: Pseudorandom Hopping Sequence');

% Plot 3: SFHSS transmitted signal
subplot(3,1,3);
hTxSF = plot(tSF, txSF.tx(1:nShowSF), 'LineWidth', 0.8);
hold on;

if rxSF.EbN0dB < 12
    hRxSF = plot(tSF, rxSF.rx(1:nShowSF), 'LineWidth', 0.6);
    legend([hTxSF hRxSF], ...
        {'Transmitted Signal', 'Received Signal with AWGN'}, ...
        'Location', 'best');
else
    legend(hTxSF, {'Transmitted Signal'}, 'Location', 'best');
end

grid on;
if nShowSF > 1
    xlim([tSF(1) tSF(end)]);
end
xlabel('Time (s)');
ylabel('Amplitude');
title(sprintf('SFHSS Transmission (Eb/N0 = %.1f dB)', ...
    rxSF.EbN0dB));

%% FIGURE 2: FFHSS TRANSMISSION AND RECEPTION
figure(2);
clf;
set(gcf, 'Name', 'FFHSS Transmission and Reception', 'Color', 'w');

nShowBitsFF = min([64, numel(originalBitsFF), txFF.numBits]);
nShowFF = min([nShowBitsFF * cfg.sps, ...
    numel(txFF.tx), numel(rxFF.rx), numel(txFF.hopFreq)]);

tFF = (0:nShowFF-1) / cfg.Fs;

% Plot 1: Original message bits
subplot(3,1,1);
stairs(0:nShowBitsFF-1, originalBitsFF(1:nShowBitsFF), ...
    'LineWidth', 1.2);
ylim([-0.2 1.2]);
xlim([0 max(1,nShowBitsFF-1)]);
yticks([0 1]);
grid on;
xlabel('Bit Index');
ylabel('Bit Value');
title('FFHSS: Original Message Bits');

% Plot 2: FFHSS hopping-frequency sequence
subplot(3,1,2);
stairs(tFF, txFF.hopFreq(1:nShowFF)/1e3, ...
    'LineWidth', 1.1);
grid on;
if nShowFF > 1
    xlim([tFF(1) tFF(end)]);
end
xlabel('Time (s)');
ylabel('Frequency (kHz)');
title('FFHSS: Pseudorandom Hopping Sequence');

% Plot 3: FFHSS transmitted signal
subplot(3,1,3);
hTxFF = plot(tFF, txFF.tx(1:nShowFF), 'LineWidth', 0.8);
hold on;

if rxFF.EbN0dB < 12
    hRxFF = plot(tFF, rxFF.rx(1:nShowFF), 'LineWidth', 0.6);
    legend([hTxFF hRxFF], ...
        {'Transmitted Signal', 'Received Signal with AWGN'}, ...
        'Location', 'best');
else
    legend(hTxFF, {'Transmitted Signal'}, 'Location', 'best');
end

grid on;
if nShowFF > 1
    xlim([tFF(1) tFF(end)]);
end
xlabel('Time (s)');
ylabel('Amplitude');
title(sprintf('FFHSS Transmission (Eb/N0 = %.1f dB)', ...
    rxFF.EbN0dB));

%% FIGURE 3: MESSAGE RECONSTRUCTION AND BER
figure(3);
clf;
set(gcf, 'Name', 'FHSS Message Reconstruction and BER', 'Color', 'w');

% Plot 1: SFHSS original vs reconstructed message bits
subplot(3,1,1);

nCompareSF = min([numel(originalBitsSF), ...
    numel(recoveredBitsSF), 32]);

if nCompareSF > 0
    idxSF = 0:nCompareSF-1;

    hOriginalSF = stairs(idxSF, ...
        originalBitsSF(1:nCompareSF), ...
        'r--', 'LineWidth', 1.5);
    hold on;

    hRecoveredSF = stairs(idxSF, ...
        recoveredBitsSF(1:nCompareSF), ...
        'b-', 'LineWidth', 1.2);

    legend([hOriginalSF hRecoveredSF], ...
        {'Original Message Bits', 'Reconstructed Message Bits'}, ...
        'Location', 'best');

    xlim([0 max(1,nCompareSF-1)]);
else
    text(0.5, 0.5, 'No SFHSS bits available', ...
        'HorizontalAlignment', 'center');
end

ylim([-0.2 1.2]);
yticks([0 1]);
grid on;
xlabel('Bit Index');
ylabel('Bit Value');
title('SFHSS: Original vs Reconstructed Message Bits');

% Plot 2: FFHSS original vs reconstructed message bits
subplot(3,1,2);

nCompareFF = min([numel(originalBitsFF), ...
    numel(recoveredBitsFF), 32]);

if nCompareFF > 0
    idxFF = 0:nCompareFF-1;

    hOriginalFF = stairs(idxFF, ...
        originalBitsFF(1:nCompareFF), ...
        'r--', 'LineWidth', 1.5);
    hold on;

    hRecoveredFF = stairs(idxFF, ...
        recoveredBitsFF(1:nCompareFF), ...
        'b-', 'LineWidth', 1.2);

    legend([hOriginalFF hRecoveredFF], ...
        {'Original Message Bits', 'Reconstructed Message Bits'}, ...
        'Location', 'best');

    xlim([0 max(1,nCompareFF-1)]);
else
    text(0.5, 0.5, 'No FFHSS bits available', ...
        'HorizontalAlignment', 'center');
end

ylim([-0.2 1.2]);
yticks([0 1]);
grid on;
xlabel('Bit Index');
ylabel('Bit Value');
title('FFHSS: Original vs Reconstructed Message Bits');

% Plot 3: BER comparison
subplot(3,1,3);

berFloor = 0.5 / cfg.berNumBits;

hBerSF = semilogy(results.EbN0dB, ...
    max(results.ber(1,:), berFloor), ...
    'o-', 'LineWidth', 1.4, 'MarkerSize', 6);
hold on;

hBerFF = semilogy(results.EbN0dB, ...
    max(results.ber(2,:), berFloor), ...
    's-', 'LineWidth', 1.4, 'MarkerSize', 6);

hTheory = semilogy(results.EbN0dB, ...
    results.theory, 'k--', 'LineWidth', 1.4);

grid on;
xlabel('E_b/N_0 (dB)');
ylabel('Bit Error Rate (BER)');
title('SFHSS vs FFHSS BER over AWGN');

legend([hBerSF hBerFF hTheory], ...
    {'SFHSS', 'FFHSS', 'Theoretical Coherent BPSK'}, ...
    'Location', 'southwest');

ylim([max(1e-5, berFloor), 1]);

%% DISPLAY MESSAGE RECONSTRUCTION RESULTS
fprintf('\n--- Message Reconstruction Results ---\n');

nSF = min(numel(originalBitsSF), numel(recoveredBitsSF));
nFF = min(numel(originalBitsFF), numel(recoveredBitsFF));

errorsSF = sum(originalBitsSF(1:nSF) ~= recoveredBitsSF(1:nSF));
errorsFF = sum(originalBitsFF(1:nFF) ~= recoveredBitsFF(1:nFF));

exactMatchSF = numel(originalBitsSF) == numel(recoveredBitsSF) && ...
    isequal(originalBitsSF, recoveredBitsSF);

exactMatchFF = numel(originalBitsFF) == numel(recoveredBitsFF) && ...
    isequal(originalBitsFF, recoveredBitsFF);

fprintf('SFHSS original bits:      %d\n', numel(originalBitsSF));
fprintf('SFHSS reconstructed bits: %d\n', numel(recoveredBitsSF));
fprintf('SFHSS comparison errors:  %d/%d\n', errorsSF, nSF);
fprintf('SFHSS exact match:        %s\n\n', yes_no(exactMatchSF));

fprintf('FFHSS original bits:      %d\n', numel(originalBitsFF));
fprintf('FFHSS reconstructed bits: %d\n', numel(recoveredBitsFF));
fprintf('FFHSS comparison errors:  %d/%d\n', errorsFF, nFF);
fprintf('FFHSS exact match:        %s\n', yes_no(exactMatchFF));

fprintf('--------------------------------------\n');

end


%% LOCAL FUNCTION: VALIDATE BINARY DATA
function validate_bits(bits, description)

if isempty(bits)
    error('%s bit sequence is empty.', description);
end

if any(~isfinite(bits)) || any(bits ~= 0 & bits ~= 1)
    error('%s must contain only binary values 0 and 1.', description);
end

end


%% LOCAL FUNCTION: FORMAT YES/NO
function output = yes_no(value)

if value
    output = 'YES';
else
    output = 'NO';
end

end