clc;
clear all;
close all;
b=round(rand(1,30));
bitpattern=[];
for k=1:30  
   if b(1,k)==0
       sig=-ones(1,20);
   else
       sig=ones(1,20);
   end
   bitpattern=[bitpattern sig]; 
end 
subplot(4,1,1);
plot(bitpattern);  
axis([-1 300 -1.5 1.5]);
title('Original Bit Sequence');
d=round(rand(1,120));
pn_seq=[];
carrier=[];
t=[0:2*pi/4:2*pi];
for k=1:120 
    if d(1,k)==0 
        sig=-ones(1,5);
    else
        sig=ones(1,5);
    end
    c=cos(t);
    carrier=[carrier c]; 
    pn_seq=[pn_seq sig];
end
spreading_sig=bitpattern.*pn_seq;
subplot(4,1,2);
plot(spreading_sig);
axis([-1 300 -1.5 1.5]);
title('Spreaded signal');
bpsk_sig=spreading_sig.*carrier;
subplot(4,1,3);
plot(bpsk_sig);
axis([-1 300 -1.5 1.5]); 
title('BPSK Modulated Signal');
figure
rxsig=bpsk_sig.*carrier;
demod_sig=[];
for i=1:600
    if rxsig(i)>=0
        rxs=1;
    else
        rxs=-1;
    end    
    demod_sig=[demod_sig rxs];
end 
subplot(3,1,1);
plot(demod_sig);
axis([-1 300 -1.5 1.5]);
title('Demodulated Signal');
despread_sig=demod_sig.*pn_seq;
subplot(3,1,2);
plot(despread_sig);
axis([-1 309 -1.5 1.5]);
title('Despreaded data');
