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

%----------------------------S(t)변조된 메시지
sound(St,fs);
figure, plot(t,St);
axis([0 10 -5 5]);
xlabel('t[sec]');
ylabel('S(t)');
title('S(t) modulated message');

%----------------------------S(t)변조된 메시지의 주파수
dftm=dft_new2(St,N);
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(dftm(N/2+1:N)) abs(dftm(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('S(t) modulated message frequency');
title('S(t) modulated message frequency');
grid;
axis([-fs/2 fs/2 -10 1000]);


%--------------------------------필터들 만들기
LBPF=BPF_design2(Ts,500,1500,N);
UBPF=BPF_design2(Ts,1500,2500,N);



LSSB_SiG=conv_new(LBPF,St);
USSB_SiG=conv_new(UBPF,St);

 N=N*2;

figure, plot([0:length(LSSB_SiG)-1]*Ts,LSSB_SiG);
axis([0 10 -10 10]);
xlabel('t[sec]');
ylabel('LSSB SiG(t)');
title('LSSB SiG(t)');
 
dftm=dft_new2(LSSB_SiG,N);
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(dftm(N/2+1:N)) abs(dftm(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('LSSB modulated message frequency');
title('LSSB modulated message frequency');
grid;
axis([-fs/2 fs/2 -10 1000]);



figure, plot([0:length(USSB_SiG)-1]*Ts,USSB_SiG);
axis([0 10 -10 10]);
xlabel('t[sec]');
ylabel('USSB SiG(t)');
title('USSB SiG(t)');
 
dftm=dft_new2(USSB_SiG,N);
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(dftm(N/2+1:N)) abs(dftm(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('USSB modulated message frequency');
title('USSB modulated message frequency');
grid;
axis([-fs/2 fs/2 -10 1000]);


%----------------------------로컬오실레이터
LOPS=AHc*cos(-2*pi*fc*[0:length(LSSB_SiG)-1]*Ts);


%----------------------------로컬 오실레이터 통과
VL=LOPS.*LSSB_SiG;
VU=LOPS.*USSB_SiG;

figure, plot([0:length(VL)-1]*Ts,VL);
axis([0 10 -5 5]);
xlabel('t[sec]');
ylabel('LSSB V(t)');
title('LSSB V(t)');

dftVL=dft_new2(VL,N);
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(dftVL(N/2+1:N)) abs(dftVL(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('LSSB V(t) frequency');
title('LSSB V(t) frequency');
grid;
axis([-fs/2 fs/2 -10 500]);



figure, plot([0:length(VU)-1]*Ts,VU);
axis([0 10 -5 5]);
xlabel('t[sec]');
ylabel('USSB V(t)');
title('USSB V(t)');

dftVu=dft_new2(VU,N);
figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(dftVu(N/2+1:N)) abs(dftVu(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('USSB V(t) frequency');
title('USSB V(t) frequency');
grid;
axis([-fs/2 fs/2 -10 500]);



LPF=LPF_design2(Ts,1000,N);
%----------------------------로우패스필터 통과
MUT=conv_new(LPF,VU);
MLT=conv_new(LPF,VL);


N=N*2;
dftMUT=dft_new2(MUT,N);
dftMLT=dft_new2(MLT,N);


sound(MLT,fs);
figure, plot(0:Ts:(length(MLT)-1)*Ts,MLT);
axis([0 10 -5 5]);
xlabel('t[sec]');
ylabel('복조된 message - - - LSSB');
title('복조된 message - - - LSSB');

figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(dftMLT(N/2+1:N)) abs(dftMLT(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('복조된 message frequency - - - LSSB');
title('복조된 message frequency - - - LSSB');
grid;
axis([-fs/2 fs/2 -10 1000]);


sound(MUT,fs);
figure, plot(0:Ts:(length(MUT)-1)*Ts,MUT);
axis([0 10 -5 5]);
xlabel('t[sec]');
ylabel('복조된 message - - - USSB');
title('복조된 message - - - USSB');

figure, plot([-fs/2:fs*1/N:fs*(N/2-1)/N],[abs(dftMUT(N/2+1:N)) abs(dftMUT(1:N/2))]);
xlabel('frequency [Hz]');
ylabel('복조된 message frequency - - - USSB');
title('복조된 message frequency - - - USSB');
grid;
axis([-fs/2 fs/2 -10 1000]);






