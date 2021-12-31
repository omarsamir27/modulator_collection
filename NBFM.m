classdef NBFM
    methods(Static)
        function modulated = modFM(audio,fc,fs,kf)
            dsbobj = dsbmod(audio.filtered_data,1e5,audio.fs,5);
            % Integration of Msg
            int_M = cumsum(dsbobj.resampled_msg)/fs;
            t=linspace(0,length(int_M)/fs,length(int_M));
            % Generating FM Modded Msg
            modulated = cos(2*pi*fc*t' + 2*pi*kf*int_M);
        end
        function demodulated = demodFM(moddedFM,fs,kf)
            [p,q] = rat(48/500);
            % Discriminator to Convert to AM
            differentiated = diff(moddedFM)*fs/kf/2*pi;
            differentiated = [0;differentiated];
            % Envelope Detection
            envelop=abs(hilbert(differentiated));
            % Remove DC
            demod = envelop - mean(envelop);
            % Remove High Freqs
            demod = lowpass(demod,4000,5e5,'ImpulseResponse','iir','Steepness',0.999);
            % Downsample Again
            demodulated=resample(demod,p,q);
        end
    end
end





