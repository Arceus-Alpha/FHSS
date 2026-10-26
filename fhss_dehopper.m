function correlationInput = fhss_dehopper(rx,phaseHat,cfg)
% Coherent dehopping/correlation using the known local hopped carrier.
localCarrier = cfg.carrierAmplitude*cos(phaseHat);
correlationInput = rx .* localCarrier;
end
