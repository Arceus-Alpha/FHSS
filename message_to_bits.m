function bits = message_to_bits(message)
% ASCII text to serial bits, most-significant bit first.
bytes = uint8(message);
bitMatrix = false(numel(bytes),8);
for k = 1:8
    bitMatrix(:,k) = bitget(bytes,9-k) ~= 0;
end
bits = double(reshape(bitMatrix.',1,[]));
end
