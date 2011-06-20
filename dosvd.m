
SEP = '\t'
M = dlmread('data/data.txt')
C = dlmread('data/concepts.txt') # trim blank first lines
P = dlmread('data/programmes.txt')

clf
hold on;
grid on;
labels; # runs our generated labels.m file (made with programmes.txt and labels.rb)

[U,S,V]=svd(M) 

X = U*S(: , 1:1)
Y = U*S(: , 2:2)

clf;
#for K = 1:30 # take 30 programmes
for K = 2:30 # take 30 programmes
 text(X(K),Y(K), PL(K) )
end

