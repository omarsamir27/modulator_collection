classdef dsbmod
    properties
        fs_original
        resampled_msg
        carrier
    end
    methods
        function obj = dsbmod(msgsig,fc,fs_original,Xnyquist)
            obj.fs_original = fs_original;
            new_fs = fc*Xnyquist;
            [p,q] = rat(new_fs/fs_original);
            obj.resampled_msg = resample(msgsig,p,q);
            msg_len = length(obj.resampled_msg);
            obj.carrier = commonspectrum.gen_carrier(fc,0,msg_len/new_fs,msg_len);
        end
        function sc = suppressed_carrier(obj,Ac)
            sc = (Ac .* obj.carrier) .* obj.resampled_msg;
        end
        function tc = transmitted_carrier(obj,Mu)
            Ac = Mu/max(obj.resampled_msg);
            tc = Ac*(Ac + Mu * obj.resampled_msg) .* obj.carrier;
        end
    end
end