clear all;
close all;

Ts=1/400; %[sec]
fs=1/Ts;
t=0:Ts:0.5-Ts;% [sec]

N=1024;
p=0.0001;

S1=sin(2*pi*60*t);
S2=sin(2*pi*40*t)+sin(2*pi*60*t)+cos(2*pi*80*t);
S3=sin(2*pi*55*t)+sin(2*pi*60*t)+cos(2*pi*80*t);

BPF=BPF_design(Ts,50,70,N,p);

BPF_PASSED_S1=conv_new(BPF,S1);
BPF_PASSED_S2=conv_new(BPF,S2);
BPF_PASSED_S3=conv_new(BPF,S3);

DFT_S1=dft_new(S1,N);
DFT_S2=dft_new(S2,N);
DFT_S3=dft_new(S3,N);
DFT_BPF_PASSED_S1=dft_new(BPF_PASSED_S1,N);
DFT_BPF_PASSED_S2=dft_new(BPF_PASSED_S2,N);
DFT_BPF_PASSED_S3=dft_new(BPF_PASSED_S3,N);

% plotting 'BPF_S1' 
figure, plot(t,S1);
xlabel('time [s]');
ylabel('BPF 실험의 S1(t)');
title('BPF 실험의 S1(t)의 신호');
grid;
axis([0 0.5 -3 3]);

figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(DFT_S1(N/2+1:N)) abs(DFT_S1(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('DFT-S1');
title('DFT-S1');
grid;
axis([-fs/4 fs/4 -10 400]);

% plotting 'BPF_S2' 
figure, plot(t,S2);
xlabel('time [s]');
ylabel('BPF 실험의 S2(t)');
title('BPF 실험의 S2(t)의 신호');
grid;
axis([0 0.5 -3 3]);

figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(DFT_S2(N/2+1:N)) abs(DFT_S2(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('DFT-S2');
title('DFT-S2');
grid;
axis([-fs/4 fs/4 -10 400]);

% plotting 'BPF_S3' 
figure, plot(t,S3);
xlabel('time [s]');
ylabel('BPF 실험의 S3(t)');
title('BPF 실험의 S3(t)의 신호');
grid;
axis([0 0.5 -3 3]);

figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(DFT_S3(N/2+1:N)) abs(DFT_S3(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('DFT-S3');
title('DFT-S3');
grid;
axis([-fs/4 fs/4 -10 400]);

% plotting 'BPF_PASSED_S1' 
figure, plot(0:Ts:0.5+(N/2*Ts)-2*Ts,BPF_PASSED_S1);
xlabel('time [s]');
ylabel('BPF 통과한 S1(t)');
title('BPF 통과한 S1(t)의 신호');
grid;
axis([0 1.5 -20 20]);

figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(DFT_BPF_PASSED_S1(N/2+1:N)) abs(DFT_BPF_PASSED_S1(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('DFT-BPF-PASSED-S1');
title('DFT-BPF-PASSED-S1');
grid;
axis([-fs/4 fs/4  -10 1000]);

% plotting 'BPF_PASSED_S2' 
figure, plot(0:Ts:0.5+(N/2*Ts)-2*Ts,BPF_PASSED_S2);
xlabel('time [s]');
ylabel('BPF 통과한 S2(t)');
title('BPF 통과한 S2(t)의 신호');
grid;
axis([0 1.5 -20 20]);

figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(DFT_BPF_PASSED_S2(N/2+1:N)) abs(DFT_BPF_PASSED_S2(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('DFT-BPF-PASSED-S2');
title('DFT-BPF-PASSED-S2');
grid;
axis([-fs/4 fs/4  -10 1000]);

% plotting 'BPF_PASSED_S3' 
figure, plot(0:Ts:0.5+(N/2*Ts)-2*Ts,BPF_PASSED_S3);
xlabel('time [s]');
ylabel('BPF 통과한 S3(t)');
title('BPF 통과한 S3(t)의 신호');
grid;
axis([0 1.5 -20 20]);

figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(DFT_BPF_PASSED_S3(N/2+1:N)) abs(DFT_BPF_PASSED_S3(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('DFT-BPF-PASSED-S3');
title('DFT-BPF-PASSED-S3');
grid;
axis([-fs/4 fs/4  -10 1000]);
