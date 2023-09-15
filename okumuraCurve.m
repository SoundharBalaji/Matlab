clc;
close all;
clear all;

x = [100,200,300,500,700,1000,2000,3000];
y1 = [15,18,19,20,22,23,25,27];
y2 = [18,21,23,24,26,27,28,30];
y5 = [22,24,26,28,30,32,35,37];
y10 = [25,27,29,32,34,37,39,42];
y20 = [28,29,32,34,36,39,41,43];
y30 = [30,33,35,38,39,40,43,45];
y40 = [32,35,37,39,40,42,45,48];
y50 = [35,37,40,43,45,47,49,50];
y60 = [39,42,45,47,50,52,54,55];
y70 = [40,43,46,48,49,53,56,58];
y80 = [48,50,53,55,57,59,60,62];
y100 = [51,55,58,60,63,66,68,70];

store = input('Enter the distance:');

if (store == 1)
    plot(x,y1);
elseif (store == 2)
     plot(x,y2);
elseif (store == 5)
     plot(x,y5);
elseif (store == 10)
    plot(x,y10);
elseif (store == 20)
    plot(x,y20);
elseif (store == 30)
    plot(x,y30);
elseif (store == 40)
    plot(x,y40);
elseif (store == 50)
    plot(x,y50);
elseif (store == 60)
    plot(x,y60);
elseif (store == 70)
    plot(x,y70);
elseif (store == 80)
    plot(x,y80);
elseif (store == 100)
    plot(x,y100);
end



plot(x,y40,x,y100,x,y80,x,y1,x,y2,x,y5,x,y10,x,y20,x,y30,x,y50,x,y70,x,y60);
xline(100);
text(100,15,'1');
text(100,18,'2');
text(100,22,'5');
text(100,25,'10');
text(100,28,'20');
text(100,30,'30');
text(100,32,'40');
text(100,35,'50');
text(100,39,'60');
text(100,40,'70');
text(100,48,'80');
text(100,51,'100'); 

xlabel('Frequency in Mhz');
ylabel('Attenuation(dB)');
title('Distance',store);
