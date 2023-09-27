clc;
close all;
clear all;

hte_values = [100, 200, 300];  % Values of hte to consider
hre = 10;
gr = 1;
f = 900000000;
eirp = 1;

y = 300000000 / f;
amu = 43;
garea = 9;
edbm = 10 * log10(eirp * 1000);

d = 10:10:200;
lf = -20 * log10(y ./ (4 * pi * d));

% Initialize arrays to store l50 and prd values for each hte value
l50 = zeros(length(hte_values), length(d));
prd = zeros(length(hte_values), length(d));

% Line styles for plotting
line_styles = {'-', '--', '-.', ':'};

% Loop through each hte value
for i = 1:length(hte_values)
    hte = hte_values(i);
    ghte = 20 * log10(hte / 200);
    
    % Define a default value for ghre
    ghre = 0;
    
    if hre <= 3
        ghre = 10 * log10(hre / 3);
    elseif hre > 3 && hre < 10
        ghre = 20 * log10(hre / 3);
    end
    
    % Calculate l50 and prd for the current hte value
    l50(i, :) = lf + amu - ghte - ghre - garea;
    prd(i, :) = edbm - l50(i, :) + gr;
end

% Plot l50 and prd values for all hte values on the same graph with different line styles
figure;
subplot(2, 2, 1);

for i = 1:length(hte_values)
    plot(d, l50(i, :), line_styles{i});
    hold on;  % Hold the current plot
end

xlabel('distance');
ylabel('path loss');

subplot(2, 1, 2);

for i = 1:length(hte_values)
    plot(d, prd(i, :), line_styles{i});
    hold on;  % Hold the current plot
end

xlabel('distance');
ylabel('power received');
