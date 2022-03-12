% Setup Receiver
rx = sdrrx('Pluto', 'GainSource','Manual', 'Gain', 20, 'CenterFrequency', 5.412e9);
tx = sdrrx('Pluto');

tx.BasebandSampleRate = 70e3;
rx.BasebandSampleRate = 70e3;
% view some spectrum
rx.SamplesPerFrame = 2^15;
sa = dsp.SpectrumAnalyzer(ChannelNames = {append(string(rx.CenterFrequency/1000000), "MHz")}, ShowLegend = true);
sa.PlotMaxHoldTrace = true;
sa.YLimits = [-10,40];
sa.SampleRate = rx.BasebandSampleRate;
sa.ShowLegend = true;
while true
    sa(rx());
end 

