%filename:Fig2p2.m
% author: Jaekwon Kim
% date: April 2008
% This program plot the Fig2.2 in the book.
clear all;
close all;
T=1;
A=1;
fs=100;
t=-5:1/fs:5;
length_t=length(t);
% frequency resolution decision
N=2;
while(N<length_t)
 N=N*2;
end
g=A*rect(t/T);
G=dft_new(g,N);
% plotting time-domain signal 
figure, plot(t,g);
xlabel('time [s]');
ylabel('Arect(t/T)');
grid;
axis([-5 5 -0.1 1.1]);
% plotting frequency-domain signal
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(G(N/2+1:N)) abs(G(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('|G(f)|');
grid;
axis([-fs/2 fs/2 -10 100]);