function A=returnadj(E,n)

%E is an edge list: example --> edgeList = [1 2; 1 3; 1 4; 1 5; 2 1; 2 6;2 7;2 8 ];
%n = number of nodes

a=n;
edgeList=E;
adj = sparse(edgeList(:, 1), edgeList(:, 2), 1, a, a);
A=full(adj);