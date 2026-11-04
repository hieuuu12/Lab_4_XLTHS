clear;
funcprot(0);

function draw_sig(n, x, ttl)
    plot([n; n], [zeros(1, length(x)); x], "b");
    plot(n, x, "bo");
    plot([min(n) - 1, max(n) + 1], [0, 0], "k");
    a = gca();
    a.data_bounds = [min(n) - 1, min([x, 0]) - 1; max(n) + 1, max([x, 0]) + 1];
    a.x_ticks = tlist(["ticks", "locations", "labels"], min(n) - 1:max(n) + 1, string(min(n) - 1:max(n) + 1));
    xgrid();
    xtitle(ttl, "n", "amplitude");
endfunction

function y = circconv_fold_shift(x, h)
    N = length(x);
    M = length(h);
    xf = x(pmodulo(-(0:N - 1), N) + 1);
    mprintf("folded  x((-k) mod N)  = [%s]\n", strcat(string(xf), ", "));
    y = zeros(1, N);
    for n = 0:N - 1
        xs = xf(pmodulo((0:M - 1) - n, N) + 1);
        y(n + 1) = sum(h .* xs);
        mprintf("n = %d : x((n-k) mod N) = [%s]  ->  y(%d) = %g\n", n, strcat(string(xs), ", "), n, y(n + 1));
    end
endfunction

function [y, X] = circconv_matrix(x, h)
    N = length(x);
    M = length(h);
    X = zeros(N, M);
    for n = 0:N - 1
        X(n + 1, :) = x(pmodulo(n - (0:M - 1), N) + 1);
    end
    y = (X * h(:))';
endfunction

x = [1, 2, -3, 2, 1];
h = [1, 0, -1, -1, 1];
N = length(x);
n = 0:N - 1;

disp("Folding and shifting method");
y1 = circconv_fold_shift(x, h);
disp("y = ");  disp(y1);

disp("Matrix method");
[y2, X] = circconv_matrix(x, h);
disp("X = ");  disp(X);
disp("y = X * h = ");  disp(y2);

hp = zeros(1, N);
hp(1:length(h)) = h;
disp("error fold-shift vs matrix = ");  disp(norm(y1 - y2));
disp("error vs ifft(fft(x).*fft(h)) = ");  disp(norm(y2 - real(ifft(fft(x) .* fft(hp)))));

Ex = sum(x .^ 2);
Eh = sum(h .^ 2);
Ey = sum(y2 .^ 2);
mprintf("Energy per period: Ex = %g , Eh = %g , Ey = %g\n", Ex, Eh, Ey);

scf(1);
clf();
subplot(3, 1, 1);
draw_sig(n, x, "x(n)");
subplot(3, 1, 2);
draw_sig(n, y2, "y(n) - circular convolution, N = 5");
subplot(3, 1, 3);
ex = x .^ 2;
ey = y2 .^ 2;
plot([n - 0.1; n - 0.1], [zeros(1, N); ex], "b");
plot(n - 0.1, ex, "bo");
plot([n + 0.1; n + 0.1], [zeros(1, N); ey], "r");
plot(n + 0.1, ey, "rs");
a = gca();
a.data_bounds = [-1, 0; N, max([ex, ey]) + 2];
a.x_ticks = tlist(["ticks", "locations", "labels"], -1:N, string(-1:N));
xgrid();
xtitle(msprintf("Energy: |x(n)|^2 blue (Ex = %g), |y(n)|^2 red (Ey = %g)", Ex, Ey), "n", "energy");
