classdef commonspectrum
    methods (Static)
        function freq_plot(signal,fs,xlimits)
            y0 = fftshift(fft(signal));
            n = length(signal);
            f = (-n/2:n/2-1)*(fs/n);
            power = abs(y0).^2/n;  
            plot(f,power);
            if exist('xlimits','var')
                xlim(xlimits);
            end
            xlabel('Frequency');
            ylabel('Power');
        end
        function carrier = gen_carrier(Ac,fc
    end
end