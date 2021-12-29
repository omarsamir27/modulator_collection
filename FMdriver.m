audio=commonaudio('eric.wav',4000);
fc=1e5;fs=5*fc;kf=7;
FMmod = NBFM.modFM(audio,fc,fs,kf);
commonspectrum.freq_plot(FMmod,fs,'NBFM_Modulated.png');
FMdemod = NBFM.demodFM(FMmod,fs);
commonspectrum.freq_plot(FMdemod,audio.fs,'NBFM_Demodulated.png');