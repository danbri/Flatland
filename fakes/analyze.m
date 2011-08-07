clf;

more off 

# strip out comments first:grep -v '#' fake_prefs.txt > fake_prefs_data.txt
F = dlmread('fake_prefs.txt',"\t", 0 , 1 ) # fake prefs data, stereotypes/personas
[U,S,V] = svd(F)

names = readtextfile('names.txt')
# names = readtextfile('x.txt') # how to put labels in data file?

A=U*S
B = U*S(:,1:2)

hold on;

for K = 1:size(names)
  text( (A(:,1:1))(K) , (A(:,2:2))(K), names(K, :) )
  disp( names(K,:) )
end


# kmeans of first 2 dims
#[centroid,pointsInCluster,assignment] = myKmeans( B, 5 )
#scatter(centroid(:,1),centroid(:,2),'x');


#pie(diag(S))
hold on;

# fuzzykmeans
[centroid,L,K,norm_mean,norm_std] =kmeans( B, 5, [], 1.5, 1e-4, 0, 1, 1, 0); 
scatter(centroid(:,1),centroid(:,2),'red', 'x');

