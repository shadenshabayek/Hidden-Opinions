function R=randinterval(a,b,n)

A=a; %lower bound
B=b; %upper bound
N=n; %number of elements
%n=9;
%a=-1;b=1;
R = A + (B-A).*rand(N,1);