clc;
close all;
clear all;

pt = 50;
gt = 1.2302;
gr = 1.3412;
ht = 50;
hr = 1;
d = 1:1:20;
for i = 1:1:20 
    pr(i)=10*log((pt*gt*(ht^2)*(hr^2))/(d(i)^4)*(10^3));
end
plot(d,pr,'-x');
title("Two Ray Reflection Channel");
xlabel("Distance in Km");
ylabel("Power in dB");
disp(pr);