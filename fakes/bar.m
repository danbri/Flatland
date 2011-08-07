#legend([p1], 'Adjacency matrix from early FOAF crawl, pruned of links, 0.7 probability of link drop when each end has 2+ links. Re-ordered using 2nd smallest eigenvector of the graph laplacian.');


clf;

title('Reduced rdfweb.org graph');


# http://en.wikipedia.org/wiki/Laplacian_matrix

WP = [ 	0 1 0 0 1 0 ;
	1 0 1 0 1 0 ;
	0 1 0 1 0 0 ;
	0 0 1 0 1 1 ;
	1 1 0 1 0 0 ;
	0 0 0 1 0 0 ];

# L1 = laplacian(WP)

#rdfweb;
#Z = prune(R1,0.7)
#L = laplacian(Z)
#[V D] = eig(L)
#D(2,2)

#[V D] = eig(L)

spy(A(p,p), '+');
hold on;
for K=1:length(N1)
 K
 NAME = N1(p(K),:)
 text(1,K,NAME);
# text(K,1, NAME);
 text( K,1,NAME, 'Rotation', -90);
 # C= 100
 # line ( [ K, 0 ], [K C] )
 xlabel('people');
 ylabel('people');
end

