function f=plot_hidden_opinions(n,K,Ex,k,FO,tau,mu)

%%%%%%%SHABAYEK 2020, code for the paper "Hidden Opinions" 

%to be used to plot the results of hidden_opinions.m

%Input:
%n: number of individuals
%K: matrix with opinions of size N (number of runs) x n (number of
%individuals)
%Ex: set of expressers
%k: ttime periods needed for cv
%FO : final opinions
%tau: opinion diff threshold
%mu: parameter in law of motion 

%Output:
%evolution of opinions with a color map going from 1 (red) to -1 (blue)

jetcustom=jet(n); %color from red to blue 
r1=K(1,:); %first row gives the color, so initial opinions give the color
colors = interp1(linspace(-1, 1, n), jetcustom, r1.');

f=figure()

set(gca, 'ColorOrder', colors , 'NextPlot', 'replacechildren');
    
x=1:k;

for i=1:n
    
    y=K(:,i);
    
    I=ismember(i,Ex);    
    
    if I==1
        plot(x,y); %expressers solid line
    else
        plot(x,y,'--'); %hiders dashed
    end
    
    hold on
    
end   

    xlim([1 k]);
    ylim([-1.5 1.5])
    
    colormap(jet(10))
    cb=colorbar;
    caxis([-1 1])
    
    
    xlabel('T');
    ylabel('Opinions');
    
    drawnow 
    
    c1=length(find(FO>0.92));
    c2=length(find(FO<-0.92));
    
    title({['Out of ' , num2str(n) , ' individuals, '  num2str(c1)  ' have long-run opinion 1 and ' num2str(c2) , ' have long-run opinion -1'];[ '\tau = ' , num2str(tau) , ' and \mu = ' , num2str(mu) ]})
    
