rx = sdrrx('Pluto', 'GainSource','Manual', 'Gain', 20, 'CenterFrequency', 2.412e9);
tx = sdrrx('Pluto');

tx.BasebandSampleRate = 56e6;
rx.BasebandSampleRate = 56e6;
% view some spectrum
%rx.SamplesPerFrame = 2^11; 
frameSize = rx.SamplesPerFrame; %number of samples for frame


startFreq = 70e6; %Hz
endFreq = 6e9; %Hz
fs = rx.BasebandSampleRate;
framesToCollect = 10;
%commenting out this function becuause we already swept the spectrum.
%fileList = freqSweep(startFreq, endFreq, fs, framesToCollect);

%load data and perform processing
desiredFreqs = [97.1e6, 314.95e6, 2.142e9, 5.142e9] ; %enter the desired freq you want to view 
desiredFreq = desiredFreqs(4);
for i = 1:length(desiredFreqs)
    freqFile = findFreqFile(desiredFreqs(i));
    display(freqFile)
end
freqFile = findFreqFile(desiredFreq);
bfr = comm.BasebandFileReader(freqFile, 'SamplesPerFrame', frameSize);
samples = bfr();
bfr.release();
sa2 = dsp.SpectrumAnalyzer(ChannelNames = {append(string(desiredFreq/1000000), "MHz")}, ShowLegend = true);
sa2.ShowLegend = true;
for frame = 1:framesToCollect
    sa2(bfr());
end


