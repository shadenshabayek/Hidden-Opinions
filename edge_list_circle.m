function [E,P]=edge_list_circle(n)

%this function create the edge list for an undirected line with n individuals,
%containing self-loops.

%you can remove self-loops by unmarking line 19-23

%Input: n number of nodes
%Output: E an edge list and P is the plot 

E1=zeros(n-1,2);

for i=1:(n-1)
    E1(i,1)=i;
    E1(i,2)=i+1;
end

E1=[E1; n 1];

E2=E1(:,[2 1]);

%unmark if you don't want self loop: 

E3=zeros(n,2);

for i=1:n
    E3(i,:)=i;
end


E=[E1;E2;E3];

G=returnadj(E,n);

g=graph(G);

P=plot(g);