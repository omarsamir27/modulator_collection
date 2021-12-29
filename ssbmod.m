classdef ssbmod
    methods (Static)
        function ideal = idealSC(dsbsc,fc)
            fs = fc * 5;
            ideal = lowpass(dsbsc,fc,fs,'ImpulseResponse','iir');
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
            fs = fc * 5;
            tc = lowpass(dsbtc,fc,fs,'ImpulseResponse','iir');
        end
    end
end

