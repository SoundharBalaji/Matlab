clc;
clear all;
close all;
user1=round(rand(1,30));
bitpattern1=[];
for k=1:30
    if user1(1,k)==0
        sig=-ones(1,20);
    else
        sig=ones(1,20);
    end
    bitpattern1=[bitpattern1 sig];
end
subplot(3,2,1);
plot(bitpattern1);
axis([-1 600 -1.5 1.5]);
title('user 1 original bit sequence');
user2=round(rand(1,30));
bitpattern2=[];
for k=1:30
    if user2(1,k)==0
        sig=-ones(1,20);
    else
        sig=ones(1,20);
    end
    bitpattern2=[bitpattern2 sig];
end
subplot(3,2,2);
plot(bitpattern2);
axis([-1 600 -1.5 1.5]);
title('user 2 original bit sequence');
d1=round(rand(1,120));
pn_seq1=[];
carrier=[];
t=[0:2*pi/4:2*pi];
for k=1:120
    if d1(1,k)==0
        sig=-ones(1,5);
    else
        sig=ones(1,5);
    end
    c=cos(t);
    carrier=[carrier c];
    pn_seq1=[pn_seq1 sig];
end
subplot(3,2,3);
plot(pn_seq1);
axis([-1 600 -1.5 1.5]);
title('pn sequence 1');
spreading_sig1=bitpattern1.*pn_seq1;
subplot(3,2,4);
plot(spreading_sig1);
axis([-1 600 -1.5 1.5]);
title('spreaded signal 1');
d2=round(rand(1,120));
pn_seq2=[];
carrier=[];
t=[0:2*pi/4:2*pi];
for k=1:120
    if d2(1,k)==0
        sig=-ones(1,5);
    else
        sig=ones(1,5);
    end
    c=cos(t);
    carrier=[carrier c];
    pn_seq2=[pn_seq2 sig];
end
subplot(3,2,5);
plot(pn_seq2);
axis([-1 600 -1.5 1.5]);
title('pn sequence 2');
spreading_sig2=bitpattern2.*pn_seq2;
subplot(3,2,6);
plot(spreading_sig2);
axis([-1 600 -1.5 1.5]);
title('spreaded signal 2');
figure
bpsk_sig1=spreading_sig1.*carrier;
subplot(3,2,1);
plot(bpsk_sig1);
axis([-1 600 -1.5 1.5]);
title('BPSK Modulated Signal 1');
bpsk_sig2=spreading_sig2.*carrier;
subplot(3,2,2);
plot(bpsk_sig2);
axis([-1 600 -1.5 1.5]);
title('BPSK Modulated Signal 2');
bpsk=bpsk_sig1+bpsk_sig2;
subplot(3,2,3);
plot(bpsk);
axis([-1 600 -1.5 1.5]);
title('Transmitted CDMA signal');
snr_in_dbs=20;
L= length(bpsk);
SNR = 10^(snr_in_dbs/10); %SNR to linear scale
Esym=sum(abs((bpsk).^2)/(L)); %Calculate actual symbol energy
N0=Esym/SNR;
noiseSigma = sqrt(N0);%Standard deviation for AWGN Noise when x is real
n = noiseSigma*randn(1,L);
received_sig=bpsk+n;
%received_sig=awgn(bpsk,s,'measured');
subplot(3,2,4);
plot(received_sig);
title('Received CDMA signal');
rx1=bitpattern1.*received_sig.*pn_seq1;
subplot(3,2,5);
plot(rx1);
title('received signal of user 1');
rx2=bitpattern2.*received_sig.*pn_seq2;
subplot(3,2,6);
plot(rx2);
title('received signal of user 2 ');
figure
r1=bpsk_sig1.*carrier;
demod_sig1=[];
for i=1:600
    if r1(i)>=0
        r2=1;
    else
        r2=-1;
    end
    demod_sig1=[demod_sig1 r2];
end
subplot(3,2,1);
plot(demod_sig1);
axis([-1 600 -1.5 1.5]);
title('Demodulated signal of user 1');
despread1=demod_sig1.*pn_seq1;
subplot(3,2,2);
plot(despread1);
axis([-1 600 -1.5 1.5]);
title('despreaded data1');
r3=bpsk_sig2.*carrier;
demod_sig2=[];
for i=1:600
    if r3(i)>=0
        r4=1;
    else
        r4=-1;
    end
    demod_sig2=[demod_sig2 r4];
end
subplot(3,2,3);
plot(demod_sig2);
axis([-1 600 -1.5 1.5]);
title('Demodulated signal of user 2');
despread2=demod_sig2.*pn_seq2;
subplot(3,2,4);
plot(despread2);
axis([-1 600 -1.5 1.5]);
title('despreaded data2');
