classdef ssbdemod
    methods (Static)
    function demodulated = envelope(modulated,fcut,fs)
       temp= abs(hilbert(modulated));
       demod = temp - mean(temp);
       filtered=lowpass(demod,fcut,fs,'ImpulseResponse','iir','Steepness',0.999,'StopbandAttenuation',90);
       %HardCoded
       [p,q]=rat(48/500);
       demodulated=resample(filtered,p,q);
    end
    function demodulated = coherent(modulated,fc,fs,phase,fcut)
        len = length(modulated);
        demod = modulated.*commonspectrum.gen_carrier(fc,phase,len/fs,len);
        filtered = lowpass(demod,fcut,fs,'ImpulseResponse','iir','Steepness',0.999,'StopbandAttenuation',90);
        %HardCoded
       [p,q] = rat(48/500);
       demodulated = resample(filtered,p,q);
    end
    end
end