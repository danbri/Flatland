
M=4
W=2
H=4
S=500

a = M * [randn(S,1)+W, randn(S,1)+H];
b = M * [randn(S,1)+W, randn(S,1)-H];
c = M * [randn(S,1)-W, randn(S,1)+H];
d = M * [randn(S,1)-W, randn(S,1)-H];
e = M * [randn(S,1), randn(S,1)];

all_data = [a;b;c;d;e];

plot(a(:,1), a(:,2),'.'); 
hold on;
plot(b(:,1), b(:,2),'r.'); 
plot(c(:,1), c(:,2),'g.'); 
plot(d(:,1), d(:,2),'k.'); 
plot(e(:,1), e(:,2),'c.'); 

% using http://www.christianherta.de/kmeans.html as myKmeans.m
[centroid,pointsInCluster,assignment] = myKmeans(all_data,5) 

scatter(centroid(:,1),centroid(:,2),'x');





% http://www.mathworks.de/help/toolbox/stats/pdist.html
% http://blogs.mathworks.com/pick/2008/06/02/matlab-puzzler-finding-the-two-closest-points/
