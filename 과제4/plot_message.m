clear all; close all;

fc=1500;
Ts=1/8000;
fs=1/Ts;
Ac=1;
AHc=1;

load test_audio2.dat;
t=[0:length(test_audio2)-1]*Ts;

length_t=length(test_audio2);
N=2;
while(N<length_t)
    N=N*2;
end

%----------------------------원래 메시지
sound(test_audio2,fs);
figure, plot(t,test_audio2);
axis([0 10 -5 5]);
xlabel('t[sec]');
ylabel('m(t)');
title('original message');

message=transpose(test_audio2);
dftm=dft_new2(message,N);

%----------------------------원래 메시지의 주파수
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(dftm(N/2+1:N)) abs(dftm(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('original message frequency');
title('original message frequency');
grid;
axis([-fs/2 fs/2 -10 1000]);

Ct=Ac*cos(2*pi*fc*t);


St=message.*Ct;

%----------------------------변조된 메시지
sound(St,fs);
figure, plot(t,St);
axis([0 10 -5 5]);
xlabel('t[sec]');
ylabel('S(t)');
title('modulated message');

%----------------------------변조된 메시지의 주파수
dftm=dft_new2(St,N);
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(dftm(N/2+1:N)) abs(dftm(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('modulated message frequency');
title('modulated message frequency');
grid;
axis([-fs/2 fs/2 -10 1000]);


%----------------------------로컬오실레이터
Lo1t=AHc*cos(2*pi*fc*t+0);
Lo2t=AHc*cos(2*pi*fc*t+pi/4);
Lo3t=AHc*cos(2*pi*fc*t+pi/2);

%----------------------------로컬 오실레이터 통과
V1t=Lo1t.*St;
V2t=Lo2t.*St;
V3t=Lo3t.*St;

figure, plot(t,V1t);
axis([0 10 -5 5]);
xlabel('t[sec]');
ylabel('V_1(t)');
title('V_1(t) - - - +0');

dftV1t=dft_new2(V1t,N);
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(dftV1t(N/2+1:N)) abs(dftV1t(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('V_1(t) frequency');
title('V_1(t) frequency - - - +0');
grid;
axis([-fs/2 fs/2 -10 500]);


figure, plot(t,V2t);
axis([0 10 -5 5]);
xlabel('t[sec]');
ylabel('V_2(t)');
title('V_2(t) - - - +pi/4');

dftV2t=dft_new2(V2t,N);
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(dftV2t(N/2+1:N)) abs(dftV2t(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('V_2(t) frequency');
title('V_2(t) frequency - - - +pi/4');
grid;
axis([-fs/2 fs/2 -10 500]);


figure, plot(t,V3t);
axis([0 10 -5 5]);
xlabel('t[sec]');
ylabel('V_3(t)');
title('V_3(t) - - - +pi/2');

dftV3t=dft_new2(V3t,N);
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(dftV3t(N/2+1:N)) abs(dftV3t(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('V_3(t) frequency');
title('V_3(t) frequency - - - +pi/2');
grid;
axis([-fs/2 fs/2 -10 500]);



LPF=LPF_design2(Ts,1000,N);
%----------------------------로우패스필터 통과
M1t=conv_new(LPF,V1t);
M2t=conv_new(LPF,V2t);
M3t=conv_new(LPF,V3t);

dftM1=dft_new2(M1t,N*2);
dftM2=dft_new2(M2t,N*2);
dftM3=dft_new2(M3t,N*2);

sound(M1t,fs);
figure, plot(0:Ts:(length(M3t)-1)*Ts,M1t);
axis([0 10 -5 5]);
xlabel('t[sec]');
ylabel('복조된 message - - - +0');
title('복조된 message - - - +0');

figure, plot([-fs/2:fs*1/(N*2):fs*((N*2)/2-1)/(N*2)],[abs(dftM1((N*2)/2+1:(N*2))) abs(dftM1(1:(N*2)/2))]);
xlabel('frequency [Hz]');
ylabel('복조된 message frequency - - - +0');
title('복조된 message frequency - - - +0');
grid;
axis([-fs/2 fs/2 -10 1000]);

sound(M2t,fs);
figure, plot(0:Ts:(length(M3t)-1)*Ts,M2t);
axis([0 10 -5 5]);
xlabel('t[sec]');
ylabel('복조된 message - - - +pi/4');
title('복조된 message - - - +pi/4');

figure, plot([-fs/2:fs*1/(N*2):fs*((N*2)/2-1)/(N*2)],[abs(dftM2((N*2)/2+1:(N*2))) abs(dftM2(1:(N*2)/2))]);
xlabel('frequency [Hz]');
ylabel('복조된 message frequency - - - +pi/4');
title('복조된 message frequency - - - +pi/4');
grid;
axis([-fs/2 fs/2 -10 1000]);


sound(M3t,fs);
figure, plot(0:Ts:(length(M3t)-1)*Ts,M3t);
axis([0 10 -5 5]);
xlabel('t[sec]');
ylabel('복조된 message - - - +pi/2');
title('복조된 message - - - +pi/2');

figure, plot([-fs/2:fs*1/(N*2):fs*((N*2)/2-1)/(N*2)],[abs(dftM3((N*2)/2+1:(N*2))) abs(dftM3(1:(N*2)/2))]);
xlabel('frequency [Hz]');
ylabel('복조된 message frequency - - - +pi/2');
title('복조된 message frequency - - - +pi/2');
grid;
axis([-fs/2 fs/2 -10 1000]);
