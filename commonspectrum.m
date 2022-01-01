classdef commonspectrum
    methods (Static)
        function freq_plot(signal,fs,name)
            NFFT = 2^(ceil(log2(length(signal))));
            y0 = fftshift(fft(signal,NFFT));
            f=fs*(-NFFT/2:NFFT/2-1)/NFFT;
            freqvals = abs(y0);  
            figure('Name',name);
            pl=plot(f,freqvals);
            xlabel('Frequency');
            ylabel('Magnitude');
            saveas(pl,name);
        end
        function time_plot(signal,fs,name)
            msg_len = length(signal);
            step = msg_len/fs;
            t = linspace(0,step,msg_len);
            figure('Name',name);
            pl=plot(t,signal);
            saveas(pl,name);
        end
        function carrier = gen_carrier(fc,phase,step,message_length)
            t = linspace(0,step,message_length);
            carrier = cos(2*pi*fc*t' + phase);
        end
    end
end