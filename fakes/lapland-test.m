
# graph laplacian tests

clf
more off
N = 6

# Our Adjacency graph
# http://en.wikipedia.org/wiki/Adjacency_matrix
#  
A1 = [
       0        -1        0       -1       -1       0   ;
       -1       0       -1       0       -1       0   ;
       0       -1       0       0       -1       0   ; 
       -1       0       0       0       -1       0   ;
       -1       -1       -1       -1       0       -1  ;
       0       0       0       0       -1       0 ]


# RDFWeb shirt
# http://swordfish.rdfweb.org/people/libby/rdfweb/tshirts/tshirt5p.jpg

N1 =  readtextfile('rdfwebnames.txt') # load up our names
# should be symmetric on diagonal; redundant but that helps with QA; some basic consistency checks are below.

R1 = [ 
#
#mitch. bhagh.  phil.   gid     barstow  poulter michael sarahm  pldms    keiren  seals   dajobe  craig   libby   louise  jane    martin  lotta   chaals  danbri  ruth    liz     william rael    edd     aaron   mags    jang    sbp     gregory kateb   emiller connolly matola weibel  swick   baker       
0       0       0       0       0        1       0       0       0        0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 1 mitchell      
0       0       0       0       0        1       0       0       0        0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 2 bhagesh
0       0       0       0       0        1       0       0       0        0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 3 philhall
0       0       0       0       0        1       0       0       0        0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 4 gid
0       0       0       0       0        0       0       0       0        0       0       0       0       0       0       0       0       0       0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 5 barstow
1       1       1       1       0        0       0       0       1        0       1       1       1       1       0       0       0       0       0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 6 poulter
0       0       0       0       0        0       0       0       0        0       0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       1       0       0       0       0       0       # 7 michael
0       0       0       0       0        0       0       0       1        0       0       0       0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 8 sarahm
0       0       0       0       0        1       0       1       0        0       0       0       1       1       0       0       0       0       0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 9 pldms
0       0       0       0       0        0       0       0       0        0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 10 keiren
0       0       0       0       0        1       0       0       0        0       0       0       0       0       1       1       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 11 seals
0       0       0       0       0        1       1       0       0        0       0       0       0       0       0       0       0       0       0       1       0       0       0       0       0       0       0       0       0       0       0       1       0       0       0       0       0       # 12 dajobe
0       0       0       0       0        1       0       0       1        0       0       0       0       1       0       0       0       0       0       1       0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 13 craig
0       0       0       0       0        1       0       1       1        0       0       0       1       0       1       0       0       0       1       1       0       0       1       0       0       0       0       0       0       1       1       0       0       0       0       0       0       # 14 libby
0       0       0       0       0        0       0       0       0        0       1       0       0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 15 louise
0       0       0       0       0        0       0       0       0        0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 16 jane
0       0       0       0       0        0       0       0       0        0       1       0       0       0       0       0       0       1       0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 17 martin
0       0       0       0       0        0       0       0       0        0       0       0       0       0       0       0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 18 lotta
0       0       0       0       0        0       0       0       0        0       0       0       0       1       0       0       0       0       0       1       0       0       1       0       0       0       0       0       0       1       0       0       0       0       0       0       0       # 19 chaals
0       0       0       0       1        1       0       0       1        0       0       1       1       1       0       0       1       0       1       0       0       0       0       1       1       1       1       1       0       0       1       1       1       1       0       0       0       # 21 danbri
0       0       0       0       0        0       0       0       0        0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       1       0       0       0       0       0       0       0       0       0       # 22 ruth
0       0       0       0       0        0       0       0       0        0       0       0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 22 liz
0       0       0       0       0        0       0       0       0        0       0       0       0       1       0       0       0       0       1       0       0       0       0       0       0       0       0       0       1       1       0       0       0       0       0       0       0       # 23 william
0       0       0       0       0        0       0       0       0        0       0       0       0       0       0       0       0       0       0       1       0       0       0       0       1       1       0       0       0       0       0       0       0       0       0       0       0       # 24 rael
0       0       0       0       0        0       0       0       0        0       0       0       0       0       0       0       0       0       0       1       0       0       0       1       0       1       0       0       0       0       0       0       0       0       0       0       0       # 25 edd
0       0       0       0       0        0       0       0       0        0       0       0       0       0       0       0       0       0       0       1       0       0       0       1       1       0       0       0       1       0       0       1       1       0       0       0       0       # 26 aaron
0       0       0       0       0        0       0       0       0        0       0       0       0       0       0       0       0       0       0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 27 mags
0       0       0       0       0        0       0       0       0        0       0       0       0       0       0       0       0       0       0       1       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 28 jang
0       0       0       0       0        0       0       0       0        0       0       0       0       0       0       0       0       0       0       0       0       0       1       0       0       1       0       0       0       0       0       0       0       0       0       0       0       # 29 sbp
0       0       0       0       0        0       0       0       0        0       0       0       0       1       0       0       0       0       1       0       0       0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 30 gregory
0       0       0       0       0        0       0       0       0        0       0       0       0       1       0       0       0       0       0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 31 kateb
0       0       0       0       0        0       1       0       0        0       0       1       0       0       0       0       0       0       0       1       0       0       0       0       0       1       0       0       0       0       0       0       1       1       1       1       1       # 32 emiller
0       0       0       0       0        0       0       0       0        0       0       0       0       0       0       0       0       0       0       1       0       0       0       0       0       1       0       0       0       0       0       1       0       0       0       0       0       # 33 connolly
0       0       0       0       0        0       0       0       0        0       0       0       0       0       0       0       0       0       0       1       0       0       0       0       0       0       0       0       0       0       0       1       0       0       0       0       0       # 34 matola
0       0       0       0       0        0       0       0       0        0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       1       0       0       0       0       0       # 35 weibel
0       0       0       0       0        0       0       0       0        0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       1       0       0       0       0       0       # 36 swick
0       0       0       0       0        0       0       0       0        0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       1       0       0       0       0       0       # 37 baker
] ;

for K=1:size(N1)
  disp("Checking...")
  disp(K)
  disp( N1(K,:) )
  disp( sum(R1(K,:)) )
  disp("\n")
  for J=1:size(N1)
    if (R1(K,J) != R1(J,K) )
      warning("Asmmetry between")
      warning( N1(K,:))
      warning( N1(J,:))
    end
  end
end

if (diag(R1)==zeros)
  disp("Diagonal is zero")
else
  warning("Non-zero diagonal!")
end



# lessons: symmetry (effective) of foaf:knows;  missing isn't broken; open-world assumptions. time/change. 

# Target Laplacian representation
# http://en.wikipedia.org/wiki/Laplacian_matrix
# http://mathworld.wolfram.com/LaplacianMatrix.html
# 
L1 = [
       3        -1        0       -1       -1       0   ;
       -1       3       -1       0       -1       0   ;
       0       -1       2       0       -1       0   ; 
       -1       0       0       2       -1       0   ;
       -1       -1       -1       -1       5       -1  ;
       0       0       0       0       -1       1 ]
 

Z = zeros(N);
S = abs(sum(A1))

for K = 1:N
  Z(K,K)=S(K)
end

L2 = A1+Z;
[a,b]=eig(L2)

if L1 == L2
#  text (10,10, "OK")
  disp("OK, matrices match.")
else
#  text(10,10, "Not OK")
  warning("NOT OK")
end
