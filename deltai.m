function di=deltai(G,n,i)

 %%%%%%%% SHABAYEK 2020, code for the paper "Hidden Opinions" 
 
%Description for a given node $i$ computes the local popularity parameter defined in the paper. 

%step 1: remove the diaginal terms:
Gr=G-eye(n,n);

%step 2: recover the degrees
[deg,indeg,outdeg]=degrees(Gr); 
D=outdeg;  

%Step3: find the set of neighbors of each node
N=find(Gr(:,i));
k=size(N,1);

%Step 4: compute the sum of degrees of neighbors for each node

DOMI=[];

for j=1:k
    DOMI(j)=D(N(j));
end

domi=sum(DOMI);

%Step 5: compute Delta  
di=(D(i)^2)/domi ;


    
