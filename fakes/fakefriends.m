# from http://www.stanford.edu/~dgleich/demos/matlab/random_graphs/erdosreyni.html
# needs graphviz + glue code

n = 150;
p = 0.01; 

G = rand(n,n) < p;
G = triu(G,1);
G = G + G'; 

thres_giant = 1/(n-1);

[x y] = draw_dot(G);
