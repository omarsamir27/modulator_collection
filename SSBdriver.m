audio=commonaudio('eric.wav',4000);
modulated=dsbmod(audio.filtered_data,1e5,audio.fs,5);
fs = 5e5;
%double side band supressed carrier modulation 
dsbSC=modulated.suppressed_carrier(1);

%single side band using ideal LPF
ssbSC = ssbmod.idealSC(dsbSC, 1e5);
commonspectrum.time_plot(ssbSC,fs,'TimeSSB-SC.png');
commonspectrum.freq_plot(ssbSC,fs,'FreqSSB-SC.png');

%coherent detection for ssb
demodulated_coherent_SSB = ssbdemod.coherent(ssbSC,1e5,5e5,0,4e3);
commonspectrum.time_plot(demodulated_coherent_SSB,48e3,'TimeSSB-SC-Demod-Coherent.png');
commonspectrum.freq_plot(demodulated_coherent_SSB,48e3,'FreqSSB-SC-Demod-Coherent.png');

%single side band using practical Butterworth
ssbSC_practical = ssbmod.practicalSC(dsbSC,1e5);
commonspectrum.time_plot(ssbSC_practical,fs,'TimeSSB-SC-Butter.png');
commonspectrum.freq_plot(ssbSC_practical,fs,'FreqSSB-SC-Butter.png');

%snr detection for ideal ssb
for i = [0,10,30]
snr=ssbdemod.coherent(awgn(ssbSC,i),1e5,5e5,0,4e3);
commonspectrum.time_plot(snr,48e3,sprintf('SSB SNR%i time.png', i));
commonspectrum.freq_plot(snr,48e3,sprintf('SSB SNR%i freq.png', i));
%sound(snr,48e3);
end

%double side band transmitted carrier modulation
dsbTC=modulated.transmitted_carrier(0.5,1);

%single side band transmitted carrier using ideal LPF
ssbTC = ssbmod.transmitted_carrier(dsbTC, 1e5);
commonspectrum.time_plot(ssbTC,fs,'TimeSSB-TC.png');
commonspectrum.freq_plot(ssbTC,fs,'FreqSSB-TC.png');

%single side band transmitted carrier demodulation using envelope detector
ssbTCenv = ssbdemod.envelope(ssbTC,4e3,fs);
commonspectrum.time_plot(ssbTCenv,48e3,'TimeSSB-TC-Demod-Env.png');
commonspectrum.freq_plot(ssbTCenv,48e3,'FreqSSB-TC-Demod-Env.png');