clc;
close all;
clear all;

% Message signal
msg = [1 0 1 0 0 1 1 0];
n = length(msg);
t = 0:0.02:n-0.02;

% Create a perfect step waveform
op = [];

for i = 1:n
    if msg(i) == 0
        op = [op zeros(1, 50)];
    elseif msg(i) == 1
        op = [op ones(1, 50)];
    end
end

% Plot message signal
subplot(2,2,1);
plot(t, op);
xlabel('Time');
ylabel('Amplitude');
title('Digital Message Signal');

% Pesudo Noise sequence
pn = [1 0 0 1 0 1 1 1];
t_pn = 0:0.02:(n/10)-0.02;

po = [];

% Create a perfect step waveform
for i = 1:n
    if pn(i) == 0
        po = [po zeros(1, 50)];
    elseif pn(i) == 1
        po = [po ones(1, 50)];
    end
end

% Plot message signal
subplot(2,2,2);
plot(t_pn, po);
xlabel('Time');
ylabel('Amplitude');
title('Pesudo Noise Signal');

%spread code

spc = msg .* pn;

ok = [];

% Create a perfect step waveform
for i = 1:n
    if spc(i) == 0
        ok = [ok zeros(1, 50)];
    elseif pn(i) == 1
        ok = [ok ones(1, 50)];
    end
end

% Plot message signal
subplot(2,2,3);
plot(ok);
xlabel('Time');
ylabel('Amplitude');
title('Spread Signal');

%carrier 


