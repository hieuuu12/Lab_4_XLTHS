clc; clear;
x = [1 2 -3 2 1];
h = [1 0 -1];
N = length(x); M = length(h); L = N + M - 1;

Xmat = zeros(L, M);
for n = 0:L-1
    for k = 0:M-1
        idx = n - k;
        if idx >= 0 & idx < N then
            Xmat(n+1, k+1) = x(idx+1);
        end
    end
end
y_mat = Xmat * h(:);

disp("Xmat = "); disp(Xmat);
disp("y_mat = "); disp(y_mat');
