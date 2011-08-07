
prompt off;

SEP = '\t'
% M = dlmread('data/data.txt')
% M misses value for prog=10

M = dlmread('data/data-b.txt', SEP, 0, 1); % last values are row, col, so we skip first col. In -b we already junked first row and sort -n'd by first col.
C = dlmread('data/concepts.txt'); # trim blank first lines
P = dlmread('data/programmes.txt'); # note tha 10th is missing in the data, maybe as id token contains a '#' ?

clf
hold on;
grid on;

%%% labels; # runs our generated labels.m file (made with programmes.txt and labels.rb)

labels2;

[U,S,V]=svd(M) 

X = U*S(: , 1:1)
Y = U*S(: , 2:2)
Z = U*S(: , 3:3)

clf;
for K = 1:35 # take 35 programmes
% text(X(K),Y(K), PL(K) )
 text(X(K),Y(K), '.' )
end

