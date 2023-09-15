clc;
clear all;
close all;
f=input('Enter the frequency:');
hte=input('Enter the height of the transmitter:');
hre=input('Enter the height of the receiver:');
d=10000;
a=(((1.1*log10(f))-0.7)*hre)-((1.56*log10(f))-0.8);
if f<=(300000000)
    ahre=8.29*(log10(1.54*hre))^2-(1.1);
elseif f>=(300000000)
    ahre=3.2*(log10(11.75*hre))^2-(4.97);
else
    disp("invalid f");
end    

l50=69.55+26.16*(log10(f))-13.82*(log10(hte))-ahre+(log10(d))*(44.9-6.55*(log10(hte)));
l50s=l50-(2*(log10(f/28))^2)-(5.4);
l50o=l50-(4.78*(log10(f))^2)+(18.33*log10(f))-(40.94);
disp("a(hre)=");
disp(ahre);
disp("l50(urban_in_db)=");
disp(l50);
disp("l50(suburban_in_db)=");
disp(l50s);
disp("l50(openrural_in_db)=");
disp(l50o);
