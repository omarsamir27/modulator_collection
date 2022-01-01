classdef dsbdemod
    methods (Static)
    function demodulated=envelope(modulated,fcut,fs)
       temp= abs(hilbert(modulated));
       filtered=lowpass(temp,fcut,fs,'ImpulseResponse','iir');
       %HardCoded
       [p,q]=rat(48/500);
       demodulated=resample(filtered,p,q);
    end
    function demodulated=coherent(modulated,fc,fs,phase,fcut)
        len=length(modulated);
        demod= modulated.*commonspectrum.gen_carrier(fc,phase,len/fs,len);
%         filtered=lowpass(demod,fcut,fs,'ImpulseResponse','iir');
        filter = generate_filter(length(demod),fs,fcut);
        temp = fftshift(fft(demod)).*filter;
        temp =ifft(ifftshift(temp));
        %HardCoded
       [p,q]=rat(48/500);
       demodulated=resample(temp,p,q);
    end
    end
end