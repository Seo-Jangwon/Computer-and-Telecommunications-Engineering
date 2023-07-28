%filename:BPF_design2.m
function [w_BPF, t_D]=BPF_design2(Ts,B_start,B_stop,N)
j=sqrt(-1);
fs=1/Ts;
N_B_start=ceil(B_start/(fs/N)); % conversion from B to k*fs/N
N_B_stop=ceil(B_stop/(fs/N)); % conversion from B to k*fs/N
W_tmp1=[zeros(1,N_B_start-10) 0 0 0 0.001 0.01 0.1 0.2 0.4 0.7 0.9 ones(1,N_B_stop-N_B_start) 0.9 0.7 0.4 0.2 0.1 0.01 0.001 0 0 0];
W_tmp2=[0 0 0 0.001 0.01 0.1 0.2 0.4 0.7 0.9 ones(1,N_B_stop-N_B_start) 0.9 0.7 0.4 0.2 0.1 0.01 0.001 0 0 0 zeros(1,N_B_start-11)];
W=[W_tmp1 zeros(1,N-length(W_tmp1)-length(W_tmp2)) W_tmp2];
d=ceil(N/10*2);
W_D=W.*exp(-j*2*pi*[0:N-1]/N*d);%exp(-j*2*pi*[0:N-1]/N*n)=exp(-j*2*pi*1/Ts*[0:N-1]/N*n*Ts)
w_tmp1=idft_new2(W_D,N);
w_tmp2=real(w_tmp1);
w_BPF=w_tmp2/sqrt(sum(w_tmp2.^2));%normalization
t_D=d*Ts;
end