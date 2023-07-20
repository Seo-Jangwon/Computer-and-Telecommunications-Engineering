function X=dft_new2(x,N);
% author: Jaekwon Kim
% date: May 2019
% x: input sequence
% N: fs/N = frequency resolution
% X: output sequence
j=sqrt(-1);
x_zero_padded=[x zeros(1,N-length(x))];
X=zeros(1,N);
n=0:N-1;
for k=0:N/2
DFT_vector=exp(-j*2*pi*k*n/N);
X(k+1)=DFT_vector*transpose(x_zero_padded);%X_k computation
X(N-k+1)=X(k+1);%X_(N-k) computation
end