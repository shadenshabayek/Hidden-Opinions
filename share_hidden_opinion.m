function [S,O]=share_hidden_opinion(N,n,edges,Alpha,mu,tau,T)

%Input:
%N : number of runs
%n: number of individuals
%edges: edge list
%Alpha: matrix with n lines and N columns 
%mu: speed in law of motion for expressers
%tau: opinion difference threshold 
%T: number of periods of interaction

%Ouput: 
%matrix S of size N lines x 3 columns.
%S(i,1) reports the share of opinion 1 holders in run i 
%S(i,2) reports the share of opinion -1 holders in run i 
%S(i,3) reports the share of mmoderate opinion holders in run i 
%O is a cell array which contains N (number of runs) matrices of size k (break time out of T)
%lines and n columns. I keep it to be able to plot the evolution of
%opinions for any single run and color the nodes... 


FOp=zeros(N,n);

S=zeros(N,3);

time=zeros(N,1);

O=cell(1,N);

for i=1:N
    
    [Ex,Con,FO,K,k]=hidden_opinions(n,edges,Alpha(:,i),mu,tau,T);
    
    FOp(i,:)=FO ;
    time(i,1)=k;
    
    S(i,1)=length(find(FOp(i,:)>0.94));
    S(i,2)=length(find(FOp(i,:)<-0.94));
    S(i,3)=length(find(FOp(i,:)<0.94 & FOp(i,:)>-0.94));
    
    O{i}=K;
    
end



