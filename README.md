# Hidden-Opinions
This is the Matlab code for the paper "Hidden Opinions" 
The are three main functions:

1) hidden_opinion.m 

This function requires a network structure A with self-loops (you can also use an edge list and use the function returnadj.m to get the adjacency matrix), an initial vector of opinions Alpha (can be generated using the function randinterval.m) along with the parameters of the model. 

It returns final opinions and the set of expressers.

2) plot_hidden_opinions.m 

This function plots the evolution of opinions over T periods. Solid line correspond to expressers, while dashed correspond to consensual. The colors correspond to te initial opinions mapped to a [-1,1 color map. 

3) plot_graph_hidden_opinions.m

This function plots a first graph with initial opinons in colors, expressers as squares and consensual as circles. Then it plots a second graph of the network structure with final opinions. It can indicate a number of network statistics such as average path length, etc. 
