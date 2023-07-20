function y=rect(x)
% author: Jaekwon Kim
% date: April 2008
% x: input sequence
% y: output sequence

non_zero_index=find (abs(x)<4);
y=zeros(1,length(x));
y(non_zero_index)=1;
