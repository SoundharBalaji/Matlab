
clc;
clear all;
close all;
b=round(rand(1,30));
signal=[];
for k=1:30
    if b(1,k)==0
        sig=-ones(1,20);
    else
        sig=ones(1,20);
    end
    signal=[signal sig];
end
subplot(5,1,1);
plot(signal);
axis([-1 600 -1.5 1.5]);
title('Random bit sequence');
d1=round(rand(1,120));
carrier=[];
t=[0:2*pi/4:2*pi];
for k=1:120
    if d1(1,k)==0
        sig=-ones(1,5);
    else
        sig=ones(1,5);
    end
    c=sin(t);
    carrier=[carrier c];
end
subplot(5,1,2);
plot(carrier);
axis([-1 600 -1.5 1.5]);
title('Carrier');
bpsk_sig=signal.*carrier;
subplot(5,1,3);
plot(bpsk_sig);
axis([-1 600 -1.5 1.5]);
title('BPSK Modulated Signal 1');
snr_in_dbs=20;
L= length(bpsk_sig);
SNR = 10^(snr_in_dbs/10); 
Esym=sum(abs((bpsk_sig).^2)/(L)); 
N0=Esym/SNR;
noiseSigma = sqrt(N0);
n = noiseSigma*randn(1,L);
received_sig=bpsk_sig+n;
subplot(5,1,4);
plot(received_sig);
title('Added Noise signal');
%N=length(received_sig);
for i=1:L
    h=(1/(sqrt(2)))*(randn(1,L)+i*randn(1,L));
end
subplot(5,1,5);
plot(h);
title('Channel Coefficient')
figure
y=h.*signal+n;
subplot(5,1,1);
plot(y);
title('Y');
eq=y./h;
subplot(5,1,2);
plot(eq);
title('Equalizer');
r1=eq;
demod_sig=[];
for i=1:600
    if r1(i)>=0
        r2=1;
    else
        r2=-1;
    end
    demod_sig=[demod_sig r2];
end
subplot(5,1,3);
plot(demod_sig);
axis([-1 600 -1.5 1.5]);
title('Demodulated Sig');
