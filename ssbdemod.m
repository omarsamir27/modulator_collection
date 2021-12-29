classdef ssbdemod
    methods (Static)
    function demodulated = envelope(modulated,fcut,fs)
       temp= abs(hilbert(modulated));
       dcShift=max(temp)-min(temp);
       demod=temp-dcShift/2;
       filtered=lowpass(demod,fcut,fs,'ImpulseResponse','iir');
       %HardCoded
       [p,q]=rat(48/500);
       demodulated=resample(filtered,p,q);
    end
    function demodulated = coherent(modulated,fc,fs,phase,fcut)
        len = length(modulated);
        demod = modulated.*commonspectrum.gen_carrier(fc,phase,len/fs,len);
        filtered = lowpass(demod,fcut,fs,'ImpulseResponse','iir');
        %HardCoded
       [p,q] = rat(48/500);
       demodulated = resample(filtered,p,q);
    end
    end
end