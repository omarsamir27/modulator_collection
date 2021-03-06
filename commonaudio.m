classdef commonaudio
    properties
        info,
        audio_file,
        filtered_data,
        fs
    end
    methods
        function obj = commonaudio(path,fcut)
            obj.info = audioinfo(path);
            [obj.audio_file,obj.fs] = audioread(path);
%             obj.filtered_data = lowpass(obj.audio_file,fcut,obj.fs,'ImpulseResponse','iir');
            filter = generate_filter(length(obj.audio_file),obj.fs,fcut);
            temp = fftshift(fft(obj.audio_file)).*filter;
            obj.filtered_data =real(ifft(ifftshift(temp)));
        end
        function play(obj,filtered)
            if strcmp(filtered,'filtered')
                player = audioplayer(obj.filtered_data,obj.fs);
            else
                player = audioplayer(obj.audio_file,obj.fs);
            end
            playblocking(player);
        end

        function freq_plot(obj)
            commonspectrum.freq_plot(obj.audio_file,obj.fs,[-6000,6000]);
        end
        function freq_plot_filtered(obj)

            commonspectrum.freq_plot(obj.filtered_data,obj.fs,[-4000,4000]);
         end
         function time_plot(obj,filtered)
            t = 0:seconds(1/obj.fs):seconds(obj.info.Duration);
            t = t(1:end-1);
            if ~filtered
                plot(t,obj.audio_file);
            else
                plot(t,obj.filtered_data);
            end
         end
    end
end