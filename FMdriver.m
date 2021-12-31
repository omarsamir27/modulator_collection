audio=commonaudio('eric.wav',4000);
fc=1e5;fs=5*fc;kf=2350;
FMmod = NBFM.modFM(audio,fc,fs,2350);
commonspectrum.freq_plot(FMmod,fs,'NBFM_Modulated.png');
FMdemod = NBFM.demodFM(FMmod,fs,2350);
commonspectrum.freq_plot(FMdemod,audio.fs,'NBFM_Demodulated.png');