function X=dft_new(x,N);
% author: Jaekwon Kim
% date: April 2008
% x: input sequence
% N: fs/N = frequency resolution
% X: output sequence

x_zero_padded=[x zeros(1,N-length(x))];
n=0:N-1;
k=transpose([0:N-1]);
DFT_matrix=exp(-j*2*pi*k*n/N);
X_temp=DFT_matrix*transpose(x_zero_padded);
X=transpose(X_temp);
