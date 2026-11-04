clc; clear;

x = [1 2 -3 2 1];
h = [1 0 -1];

N = length(x);
M = length(h);
L = N + M - 1;

y = zeros(1, L);
for n = 0:L-1
    s = 0;
    for k = 0:M-1
        idx = n - k;
        if idx >= 0 & idx < N then
            s = s + h(k+1) * x(idx+1);
        end
    end
    y(n+1) = s;
end


Ex = sum(x.^2);
Ey = sum(y.^2);
disp("Ex = "); disp(Ex);
disp("Ey = "); disp(Ey);

nx = 0:N-1;
ny = 0:L-1;

// ===== Vẽ =====
scf(1); clf;

subplot(3,1,1);
plot2d3(nx, x);
plot(nx, x, "ro");
xtitle("x(n)", "n", "x(n)");
xgrid();

subplot(3,1,2);
plot2d3(ny, y);
plot(ny, y, "bo");
xtitle("y(n) = x(n) * h(n)", "n", "y(n)");
xgrid();

subplot(3,1,3);
plot2d3([1 2], [Ex Ey]);
plot([1 2], [Ex Ey], "go");
xstring(1.05, Ex+1, "E_x = " + string(Ex));
xstring(2.05, Ey+1, "E_y = " + string(Ey));
a = gca();
a.data_bounds = [0, 0; 3, max(Ex,Ey)*1.3];
xtitle("Nang luong tin hieu", "Tin hieu", "E");
xgrid();
