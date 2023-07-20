clear all;
close all;

Ts=1/400; %[sec]
fs=1/Ts;
t=0:Ts:1-Ts;% [sec]

N=1024;
p=0.0001;

S1=sin(2*pi*10*t);
S2=cos(2*pi*20*t);

LPF=LPF_design(Ts,10,N,p);

LPF_PASSED_S1=conv_new(LPF,S1);
LPF_PASSED_S2=conv_new(LPF,S2);

DFT_S1=dft_new(S1,N);
DFT_S2=dft_new(S2,N);
DFT_LPF_PASSED_S1=dft_new(LPF_PASSED_S1,N);
DFT_LPF_PASSED_S2=dft_new(LPF_PASSED_S2,N);

% plotting 'LPF_S1' 
figure, plot(t,S1);
xlabel('time [s]');
ylabel('LPF 실험의 S1(t)');
title('LPF 실험의 S1(t)의 신호');
grid;
axis([0 1 -3 3]);

figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(DFT_S1(N/2+1:N)) abs(DFT_S1(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('DFT-S1');
title('DFT-S1');
grid;
axis([-fs/4 fs/4 -10 400]);

% plotting 'LPF_S2' 
figure, plot(t,S2);
xlabel('time [s]');
ylabel('LPF 실험의 S2(t)');
title('LPF 실험의 S2(t)의 신호');
grid;
axis([0 1 -3 3]);

figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(DFT_S2(N/2+1:N)) abs(DFT_S2(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('DFT-S2');
title('DFT-S2');
grid;
axis([-fs/4 fs/4 -10 400]);


% plotting 'LPF_PASSED_S1' 
figure, plot(0:Ts:1+(N/2*Ts)-2*Ts,LPF_PASSED_S1);
xlabel('time [s]');
ylabel('LPF 통과한 S1(t)');
title('LPF 통과한 S1(t)의 신호');
grid;
axis([0 1 -20 20]);

figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(DFT_LPF_PASSED_S1(N/2+1:N)) abs(DFT_LPF_PASSED_S1(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('DFT-LPF-PASSED-S1');
title('DFT-LPF-PASSED-S1');
grid;
axis([-fs/4 fs/4  -10 1000]);

% plotting 'LPF_PASSED_S2' 
figure, plot(0:Ts:1+(N/2*Ts)-2*Ts,LPF_PASSED_S2);
xlabel('time [s]');
ylabel('LPF 통과한 S2(t)');
title('LPF 통과한 S2(t)의 신호');
grid;
axis([0 1 -20 20]);

figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(DFT_LPF_PASSED_S2(N/2+1:N)) abs(DFT_LPF_PASSED_S2(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('DFT-LPF-PASSED-S2');
title('DFT-LPF-PASSED-S2');
grid;
axis([-fs/4 fs/4  -10 1000]);

