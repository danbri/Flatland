n = 100;
p = 0.01;
G = rand(n,n)<p;
G = triu(G,1);
G = G + G'; 
[x y] = draw_dot(G);
gplot(G, [x' y'], '.-'); 
