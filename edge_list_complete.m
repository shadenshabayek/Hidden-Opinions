function [E,P]=edge_list_complete(n)

%contains self loops, you can remove them with if condition

E=[];

for i=1:n
    
    for j=1:n
        
        E(j,1,i)=i;
        E(j,2,i)=j;
    
    end
end

%transform 3D matrix into 2D:

E=reshape(permute(E, [2 1 3]), size(E,2),[])' ;

G=returnadj(E,n);

g=graph(G);

P=plot(g);