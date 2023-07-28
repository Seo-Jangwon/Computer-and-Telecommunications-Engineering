function x=idft_new2(X,N);
% author: Jaekwon Kim
% date: April 2008
% X: input sequence; frequency domain signal
% N: fs/N = frequency resolution
% x: output sequence; time domain signal
j=sqrt(-1);
X_zero_padded=[X zeros(1,N-length(X))];
k=[0:N-1];
x=zeros(1,N);
for n=0:N-1
DFT_vector=exp(j*2*pi*k*n/N);
x(n+1)=DFT_vector*transpose(X_zero_padded);%X_k computation
end
