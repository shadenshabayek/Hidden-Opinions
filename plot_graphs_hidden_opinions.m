function f=plot_graphs_hidden_opinions(Ex,K,k,n,A)
%Shabayek 2020, paper "Hidden Opinions"

%Output: this function plots two graphs, one with initial opinions and one with
%final opinions
%
%inputs: 
% 1) EX, K and k of the function [Ex,Con,FO,K,k]=hidden_opinions(n,A,Alpha,mu,tau,T)
% 2)n number of nodes and A (adjacency matrix)

A=A-eye(n); %remove self loops from graph
f=figure();
subplot(1,2,1);

jetcustom=jet(n); 
r1=K(1,:); %list of attributes
colors = interp1(linspace(-1, 1, n), jetcustom, r1.');



a=graph(A);
p=plot(a,'Layout','force','NodeColor',colors,'EdgeColor','c');
title('T = 0');
%txt = {['Average path length : ' , num2str(l)];['Opinion difference threshold \tau: ' ,num2str(tau)];['Nb of expressers (square nodes) : ' , num2str(s),'/',num2str(n)]};
%text(2,3,txt)

highlight(p, 1:n, 'MarkerSize',6);
highlight(p, Ex, 'Marker', 's', 'MarkerSize' , 12);

for i=Ex
    for j=Ex
        if i~=j && A(i,j)==1
            highlight(p, i, j ,'EdgeColor' , 'r','LineWidth',1.5); 
        end
    end
end


set(gca,'XTick',[], 'YTick', [])
colormap(jet(10))
cb=colorbar;
caxis([-1 1])

%plot final opinions in graph A:

%figure();
subplot(1,2,2);

jetcustom=jet(n); 
r1=K(k,:); %last row gives the colors
colors = interp1(linspace(-1, 1, n), jetcustom, r1.');

%A=A-eye(n);

a=graph(A);
P=plot(a,'Layout','force','NodeColor',colors,'EdgeColor','c');
title({['T = ',num2str(k)]})

c1=length(find(K(k,:)>0.9));
c2=length(find(K(k,:)<-0.9));

%txt = {['Polarization level : ' , num2str(Max)];['Average path length : ' , num2str(l)];['Opinion difference threshold \tau: ' ,num2str(tau)];['Nb of expressers (square nodes) : ' , num2str(s),'/',num2str(n)]};
%text(2.5,3,txt)

highlight(P, 1:n, 'MarkerSize',6)
highlight(P, Ex, 'Marker', 's', 'MarkerSize' , 12)

P1=[];
for i=1:n
    if K(k,i)>0.98
        P1=[P1,i] ;
    end
    
end

highlight(P, P1, 'NodeColor', 'r') % highlight red if it is also coming out as brown ! 

for i=Ex
    for j=Ex
        if i~=j && A(i,j)==1
            highlight(P, i, j ,'EdgeColor' , 'r' , 'LineWidth',1.5); 
        end
    end
end

set(gca,'XTick',[], 'YTick', [])
colormap(jet(10))
cb=colorbar;
caxis([-1 1])
