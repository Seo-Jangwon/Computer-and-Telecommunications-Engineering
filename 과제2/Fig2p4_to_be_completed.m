%filename: Fig2p4
% author: Jaekwon Kim
% date: April 2008
% This program plot the Fig2.4 in the book.

clear all;
close all;

a=1.5;
fs=100;
t=-5:1/fs:5;
length_t=length(t);
c1=2;
c2=3;

% frequency resolution decision
N=2;
while(N<length_t)
    N=N*2;
end

g1=exp(-a*t);
negative_time_index=find(t<0);%t가 0보다 작은거 찾기
g1(negative_time_index)=0;%t가 0보다 작으면 g(t)=0

c1g1=c1*g1;

G1=dft_new(g1,N);
c1G1=c1*G1;
Nc1G1=dft_new(c1g1,N);

g2=exp(a*t);
positive_time_index=find(t>0);%t가 0보다 큰거 찾기
g2(positive_time_index)=0;%t가 0보다 크면 g(t)=0

c2g2=c2*g2;

G2=dft_new(g2,N);
c2G2=c2*G2
Nc2G2=dft_new(c2g2,N);

g3=c1g1+c2g2;
G3=dft_new(g3,N);

NG3=c1G1+c2G2;

% plotting time-domain signal 'g1' 
figure, plot(t,g1);
xlabel('time [s]');
ylabel('g_1(t)');
title('g_1(t)의 신호');
grid;
axis([-5 5 -2 3]);

% plotting time-domain signal 'c1g1'
figure, plot(t,c1g1);
xlabel('time [s]');
ylabel('c_1*g_1(t)');
title('c_1*g_1(t)의 신호(c_1=2)');
grid;
axis([-5 5 -2 3]);

% plotting frequency-domain signal 'G1'
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(G1(N/2+1:N)) abs(G1(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('|G_1(f)|');
title('g_1(t)의 푸리에 변환');
grid;
axis([-fs/2 fs/2 -10 400]);

% plotting frequency-domain signal 'c1G1'
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(c1G1(N/2+1:N)) abs(c1G1(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('c_1*|G_1(f)|');
title('g_1(t)의 푸리에 변환*c_1(c_1=2)');
grid;
axis([-fs/2 fs/2 -10 400]);

% plotting frequency-domain signal 'Nc1G1'
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(Nc1G1(N/2+1:N)) abs(Nc1G1(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('c_1*|G_1(f)|');
title('c_1g_1(t)의 푸리에 변환(c_1=2)');
grid;
axis([-fs/2 fs/2 -10 400]);


% plotting time-domain signal 'g2'
figure, plot(t,g2);
xlabel('time [s]');
ylabel('g_2(t)');
title('g_2(t)의 신호');
grid;
axis([-5 5 -2 3]);

% plotting time-domain signal 'c2g2'
figure, plot(t,c2g2);
xlabel('time [s]');
ylabel('c_2*g_2(t)');
title('c_2*g_2(t)의 신호(c_2=3)');
grid;
axis([-5 5 -2 3]);

% plotting frequency-domain signal 'G2'
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(G2(N/2+1:N)) abs(G2(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('|G_2(f)|');
title('g_2(t)의 푸리에 변환');
grid;
axis([-fs/2 fs/2 -10 400]);

% plotting frequency-domain signal 'c2G2'
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(c2G2(N/2+1:N)) abs(c2G2(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('c_2*|G_2(f)|');
title('g_2(t)의 푸리에 변환*c_2(c_2=3)');
grid;
axis([-fs/2 fs/2 -10 400]);

% plotting frequency-domain signal 'Nc2G2'
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(Nc2G2(N/2+1:N)) abs(Nc2G2(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('c_2*|G_2(f)|');
title('c_2g_2(t)의 푸리에 변환(c_2=3)');
grid;
axis([-fs/2 fs/2 -10 400]);

% plotting time-domain signal 
figure, plot(t,g3);
xlabel('time [s]');
ylabel('g_3(t)=c_1g_1(t)+c_2g_2(t)');
title('c_1g_1(t)+c_2g_2(t)의 신호');
grid;
axis([-5 5 -2 3]);

% plotting frequency-domain signal 'G3'
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(G3(N/2+1:N)) abs(G3(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('|G_3(f)|');
title('c_1g_1(t)+c_2g_2(t)의 신호의 푸리에 변환');
grid;
axis([-fs/2 fs/2 -10 400]);

% plotting frequency-domain signal 'NG3'
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(NG3(N/2+1:N)) abs(NG3(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('|NG_3(f)|=c_1*|G_1(f)|+c_2*|G_2(f)|');
title('c_1g_1(t), c_2g_2(t)의 신호의 푸리에 변환의 합');
grid;
axis([-fs/2 fs/2 -10 400]);