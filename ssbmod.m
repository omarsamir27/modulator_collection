classdef ssbmod
    methods (Static)
        function ideal = idealSC(dsbsc,fc)
            fs = fc * 5;
            ideal = bandpass(dsbsc,[1e5-4e3 1e5],fs,'ImpulseResponse','iir','Steepness',0.999,'StopbandAttenuation',90);
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
            tc = bandpass(dsbtc,[1e5-4e3 1e5],fs,'ImpulseResponse','iir','Steepness',0.999,'StopbandAttenuation',90);
        end
    end
end

