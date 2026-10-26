function message = bits_to_message(bits)
% Serial bits to ASCII text, most-significant bit first.
bits = double(bits(:).');
nBytes = floor(numel(bits)/8);
if nBytes == 0
    message = '';
    return;
end
bitMatrix = reshape(bits(1:8*nBytes),8,nBytes).';
bytes = uint8(double(bitMatrix)*(2.^(7:-1:0)).');
message = char(bytes);
end
