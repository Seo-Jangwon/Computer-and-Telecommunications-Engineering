%filename: Fig2p9
% author: Jaekwon Kim
% date: April 2008
% This program plot the Fig2.9 in the book.

clear all;
close all;

T=1;
fc=10;
fs=1638;
t=-5:1/fs:5;
length_t=length(t);

% frequency resolution decision
N=2;
while(N<length_t)
    N=N*2;
end

g=rect(t/T);
G=dft_new(g,N);
g_modulated=rect(t/T).*cos(2*pi*fc*t);
SG=dft_new(g_modulated,N);

% plotting time-domain signal 
figure, plot(t,g);
xlabel('time [s]');
ylabel('g(t)');
title('g(t)의 신호');
grid;
axis([-5 5 -2 2]);

% plotting frequency-domain signal
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(G(N/2+1:N)) abs(G(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('|G(f)|');
title('g(t)의 신호의 푸리에 변환');
grid;
axis([-fs/2 fs/2 -10 100]);

% plotting time-domain signal 
figure, plot(t,g_modulated);
xlabel('time [s]');
ylabel('g_modulated(t)');
title('g_modulated(t)의 신호');
grid;
axis([-5 5 -2 2]);

% plotting frequency-domain signal
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(SG(N/2+1:N)) abs(SG(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('|G(f-fc)|');
title('g_modulated(t)의 신호의 푸리에 변환');
grid;
axis([-fs/2 fs/2 -10 100]);