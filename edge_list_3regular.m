function [E,P]=edge_list_3regular(n)

%existence condition: n x k even and n >= k +1 
%edge list 3-regular: n=46

k=3;

if floor((n*k)/2)==((n*k)/2)
   
    E1=zeros(n-1,2);

    for i=1:n-1
        E1(i,1)=i ;
        E1(i,2)=i+1 ;
    end

    E1=[E1;n 1];

    m=n/2;

    E2=zeros(m,2);

    for i=1:m
        E2(i,1)=i;
        E2(i,2)=i+m;
    end
    
    E3=E1(:,[2 1]);    

    E4=E2(:,[2 1]);

    %self loops : 

    E5=zeros(n,2);

    for i=1:n
        E5(i,:)=i;
    end

    E=[E1;E2;E3;E4;E5];
    
    G=returnadj(E,n);

    g=graph(G);

    P=plot(g);

else
    
    E=0;
    P=0;
    disp('impossible')
    
end



