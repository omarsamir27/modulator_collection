classdef ssbmod
    methods (Static)
        function ideal = idealSC(dsbsc,fc)
            len=length(dsbsc);
            filter=generate_filter(len,5*fc,fc);
            %filter off by one
            ssbf=fftshift(fft(dsbsc)).*filter;
            ideal=real(ifft(ifftshift(ssbf)));
        end
        
        function practical = practicalSC(dsbsc,fc)
            fs = fc * 5;
            flow = (fc-4e3)/ (fs/2);
            fhigh = fc/ (fs/2);
            fcut = [flow, fhigh]; 
            [b, a] = butter(4,fcut);
            practical = filter(b, a, dsbsc);
        end
        function tc = transmitted_carrier(dsbtc,fc)
           len=length(dsbtc);
           filter=generate_filter(len,5*fc,fc);
           r = find(filter==1,1,'last');
           filter(r+1) = 1;
            ssbf=fftshift(fft(dsbtc)).*filter;
            tc=ifft(ifftshift(ssbf));
        end
    end
end

