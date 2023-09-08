clc;
close all;
clear all;

hte = 100;
hre = 10;
gr = 1;
f = 900000000;
eirp = 1;

y = 300000000 / f;
amu = 43;
garea = 9;
edbm = 10 * log10(eirp * 1000);
ghte = 20 * log10(hte / 200);

% Define a default value for ghre
ghre = 0;

if hre <= 3
    ghre = 10 * log10(hre / 3);
elseif hre > 3 && hre < 10
    ghre = 20 * log10(hre / 3);
end

d = 10:10:200;
lf = zeros(1, 20);
l50 = zeros(1, 20);
prd = zeros(1, 20);

for i = 1:20
    lf(i) = -20 * log10(y / (4 * pi * d(i)));
    l50(i) = lf(i) + amu - ghte - ghre - garea;
    prd(i) = edbm - l50(i) + gr;
end

disp('L50');
disp(l50);
disp('Power received');
disp(prd);

subplot(2, 2, 1);
plot(d, l50,'-x');
xlabel('distance');
ylabel('path loss');

subplot(2, 1, 2);
plot(d, prd,'-x');
xlabel('distance');
ylabel('power received');
