% audio=commonaudio('eric.wav',4000);
% modulated=dsbmod(audio.filtered_data,1e5,audio.fs,5);
% %modulation signal 
% dsbSC=modulated.suppressed_carrier(2);
% dsbTC=modulated.transmitted_carrier(0.5,1);
% %demodulation using envelope
% envSC=dsbdemod.envelope(dsbSC,4e3,5e5);
% envTC=dsbdemod.envelope(dsbTC,4e3,5e5);
% commonspectrum.time_plot(envSC,48e3,'envelope DSC-SC.png');
% sound(envSC,48e3);
% commonspectrum.time_plot(envTC,48e3,'envelope DSC-TC.png');
% sound(envTC,48e3);
% %SNR demodulation 
% for i = [0,10,30]
% snr=dsbdemod.coherent(awgn(dsbSC,i),1e5,5e5,0,4e3);
% commonspectrum.time_plot(snr,48e3,sprintf('SNR%i time.png', i));
% commonspectrum.freq_plot(snr,48e3,sprintf('SNR%i freq.png', i));
% sound(snr,48e3);
% end
% %FREQ/PHASE ERROR DEMODUALTION
% errFreq=dsbdemod.coherent(dsbSC,100100,5e5,0,4e3);
% commonspectrum.time_plot(errFreq,48e3,'errFreq time.png');
% commonspectrum.freq_plot(errFreq,48e3,'errFreq freq.png');
% sound(errFreq,48e3);
% errPhase=dsbdemod.coherent(dsbSC,1e5,5e5,deg2rad(20),4e3);
% commonspectrum.time_plot(errFreq,48e3,'errphase time.png');
% commonspectrum.freq_plot(errFreq,48e3,'errphase freq.png');
% sound(errFreq,48e3);