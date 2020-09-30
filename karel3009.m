n=200;
%tau=0.5; %threshold for opinion difference
mu=0.1; %speed in law of miton
T=1500; %number of iterations (loop breaks if convergence occurs before max(T))
N=10000;  %number of N randomly drawn initial opinion vectors

%Generate initial opinions (to be used for different network structures):

IO=zeros(n,N);

for i=1:N
    IO(:,i)=randinterval(-1,1,n);
end

Alpha=IO;

%Generate graph: 

A = scale_free(n, 5, 1);
% n: [1]: number of nodes
% m0: [1]: number of initially placed nodes
% m: [1]: number of nodes a new added node is connected to, 1 <= m < m0
[r,c] = find(A);
edges = [r,c];

[S,O]=share_hidden_opinion(N,n,edges,Alpha,mu,0.5,T);

L=S;
c=[find(S(:,3)==n);find(S(:,2)==n);find(S(:,1)==n)];
L(c,:)=[]; %remove consensus
L(:,[2,3])=[];

L=L/n;

figure

ksdensity(L)


hold on 

[R,P]=share_hidden_opinion(N,n,edges,Alpha,mu,0.7,T);

M=R;
c=[find(R(:,3)==n);find(R(:,2)==n);find(R(:,1)==n)];
M(c,:)=[]; %remove consensus
M(:,[2,3])=[];

M=M/n;

ksdensity(M)

legend('\tau=0.5','\tau=0.7')

hold off

%figure
%a=graph(A);
%p=plot(a,'Layout','force');

