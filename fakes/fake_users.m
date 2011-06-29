#

clf;

# strip out comments first:grep -v '#' fake_prefs.txt > fake_prefs_data.txt

F = dlmread('fake_prefs_data.txt',"\t", 0 , 1 ) # fake prefs data, stereotypes/personas
[U,S,V] = svd(F)

NAMES = { 
'Alice1',
'Alice2',
'Alice3',
'Bob1',
'Bob2',
'Bob3',
'Charlie1',
'Charlie2',
'Charlie3',
'Denise1',
'Denise2',
'Denise3',
'Eric1',
'Eric2',
'Eric3',
}

for K = 1:size(NAMES)
  text(  (U*S(:,1:1)) (K) , (U*S(: , 2:2)) (K), NAMES(K) )
end



