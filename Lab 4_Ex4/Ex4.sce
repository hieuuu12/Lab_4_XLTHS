clear;
funcprot(0);

fs = 8000;
t = 0:1/fs:1 - 1/fs;
x = 0.5 * sin(2 * %pi * 440 * t) + 0.3 * sin(2 * %pi * 2500 * t);

fin = TMPDIR + "/ex4_input.wav";
wavwrite(x, fs, 16, fin);

[y, Fs, bits] = wavread(fin);
sz = wavread(fin, "size");
mprintf("File        : ex4_input.wav\n");
mprintf("Fs          : %d Hz\n", Fs);
mprintf("Bits        : %d\n", bits);
mprintf("Channels    : %d\n", sz(1));
mprintf("Samples     : %d\n", sz(2));
mprintf("Duration    : %.2f s\n", sz(2) / Fs);
mprintf("max|y - x|  : %.2e\n", max(abs(y - x)));

h = wfir("lp", 101, [1000 / Fs, 0], "hm", [0, 0]);
z = filter(h, 1, y);
fout = TMPDIR + "/ex4_lowpass.wav";
wavwrite(z, Fs, 16, fout);
mprintf("FIR filter  : low-pass, 101 taps, fc = 1000 Hz, Hamming\n");
mprintf("Saved       : ex4_lowpass.wav\n");

L = length(y);
Y = abs(fft(y)) * 2 / L;
Z = abs(fft(z)) * 2 / L;
mprintf(" 440 Hz     : in = %.3f , out = %.3f\n", Y(440 * L / Fs + 1), Z(440 * L / Fs + 1));
mprintf("2500 Hz     : in = %.3f , out = %.3f\n", Y(2500 * L / Fs + 1), Z(2500 * L / Fs + 1));

k = 1:400;
scf(1);
clf();
subplot(2, 2, 1);
plot(t(k) * 1000, y(k), "b");
xgrid();
xtitle("Input y(t) = 440 Hz + 2500 Hz", "t (ms)", "amplitude");
subplot(2, 2, 2);
plot(t(k) * 1000, z(k), "r");
xgrid();
xtitle("Output z(t) after low-pass FIR", "t (ms)", "amplitude");
subplot(2, 2, 3);
analyze(y, 10, 4000, Fs, 8000);
xgrid();
xtitle("analyze(y)", "f (Hz)", "|FFT|");
subplot(2, 2, 4);
analyze(z, 10, 4000, Fs, 8000);
xgrid();
xtitle("analyze(z)", "f (Hz)", "|FFT|");

scf(2);
clf();
subplot(2, 1, 1);
mapsound(y, 0.05, 3900, Fs);
xtitle("mapsound(y) - input");
subplot(2, 1, 2);
mapsound(z, 0.05, 3900, Fs);
xtitle("mapsound(z) - output");

playsnd(y, Fs);
playsnd(z, Fs);
