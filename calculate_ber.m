function [ber,nErr] = calculate_ber(txBits,rxBits)
n = min(numel(txBits),numel(rxBits));
nErr = sum(txBits(1:n)~=rxBits(1:n));
ber = nErr/n;
end
