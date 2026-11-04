clc; clear;

x = [1 2 -3 2 1];
h = [1 0 -1];

N = length(x);
M = length(h);
L = N + M - 1;

y_fs = zeros(1, L);
for n = 0:L-1
    s = 0;
    for k = 0:M-1
        idx = n - k;
        if idx >= 0 & idx < N then
            s = s + h(k+1) * x(idx+1);
        end
    end
    y_fs(n+1) = s;
end

disp("===== Folding and shifting =====");
disp("x = ");  disp(x);
disp("h = ");  disp(h);
disp("y_fs = ");  disp(y_fs);

y_ref = convol(x, h);
disp("convol(x,h) = ");  disp(y_ref);
disp("sai so = ");  disp(norm(y_fs - y_ref));
