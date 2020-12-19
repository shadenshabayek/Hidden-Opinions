function [Ex,FO,K,k]=hidden_opinions(n,E,Alpha,mu,tau,T)

 %%%%%%%% SHABAYEK 2020, code for the paper "Hidden Opinions" 

%functions called (to be uploaded)

% --> returnadj
% --> deltai
% --> randinterval (optional) 
% --> degrees (pre-installed?)

%Input/PARAMETERS:

%1) n: number of agents

%2) E: edge list 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IMPORTANT: E the edge list, must contain self loops. add by doing the 
%following: 
%E1=zeros(n,2)
%for i=1:n
%   E1(i,:)=i;
%end
%E=[E;E1]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%3) Alpha: initial opinions, column vector otherwise remove "transpose" in
%line 92
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%to randomly generate Alpha do:
%%a=-1; %lower bound on opinions
%b=1; %upper bound on opinions
%Alpha=randinterval(a,b,n); %initial opinions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%mu=0.1; %4) speed in law of motion
%tau=0.5; % 5) threshold of agreement 
%T=1500; set very large number, any way there is a "break" in the "for" loop in case it finishes before %6) number of iterations can be replaced with while (many lines actually)  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Output:

%Ex: list of expressers
%FO: vector of final opinions 
%K : matrix giving the evolution of opinions
%k: break time


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Step 1: given an edge list, create adjacency matrix
G=returnadj(E,n) ;

%Step 2: recover the degrees :
[deg,indeg,outdeg]=degrees(G); 
D=outdeg;  

%Step 3: comput local populairty parameter to determine Express/Hide
delta=[];

for i=1:n
    delta(i)=deltai(G,n,i);
end

% Notice that you can use whatever centrality measure you want (just adapte the delta vector) 
Ex=find(delta>=1); %expressers
Con=find(delta<1); %consensual

%Step 4: process of interpersonal influence:

epsilon1=1-5*eps(1); % set tolerance because Matlab doesn't read 1.0000 as 1 or 0.9999999999999 as 1 (because let's face it, it's not!) 
epsilon2=-1+5*eps(-1);

M=zeros(T,n); %Opinion matrix

M(1,:)=transpose(Alpha);

L=zeros(n,n); %matrix for the law of motion, to keep track of the opinions of expressers.

for t=2:T
        
    for i=Ex
        
        for j=Ex

            if G(i,j)==1 && abs(M(t-1,i)-M(t-1,j))>=tau && M(t-1,i)>epsilon2 && M(t-1,i)<epsilon1 && i~=j
          
                L(i,j)=mu*(M(t-1,i)-M(t-1,j)) ; %neigbors who repulse
            
            elseif G(i,j)==1 && abs(M(t-1,i)-M(t-1,j))<tau && M(t-1,i)>epsilon2 && M(t-1,i)<epsilon1 && i~=j
          
                L(i,j)=mu*(M(t-1,j)-M(t-1,i))  ; % neighbors who attract
            end
      
        end
            
            M(t,i)=M(t-1,i) + sum(L(i,:)) ; % total effect/change/variation
      
            if M(t,i)<epsilon2
                
                M(t,i)=-1; %if M gets out of the bound then make it stop at the lower bound -1 ! 
          
            elseif M(t,i)>epsilon1
                
                M(t,i)=1;  %if M gets out of the bound then make it stop at the upper bound 1 !
            end
      
        
    end
    
    for i=Con
        
        M(t,i)=(G(i,:)*transpose(M(t-1,:)))/D(i);
        
    end
    
     %break in case convergence before T
     ep=ones(1,n)*(10^10)*eps;
     dif=abs(M(t,:)-M(t-1,:))<ep ;
     
     if sum(dif)==size(dif,2)
         break     
     end
    
end

%remove zero lines , if iteration breaks... if not then simply  K==M
K=M(any(M,2),:);
k=size(K,1);

%final opinions (finally!) 

FO=K(k,:);

