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
0       0       0       0       0        0       0       0       0        0       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 10 keiren
0       0       0       0       0        1       0       0       0        1       0       0       0       0       1       1       1       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       # 11 seals
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
  disp(sprintf("Checking person %d named %s. Degree count is %d \n",K, N1(K,:), sum(R1(K,:))    ))
  for J=1:size(N1)
    if (R1(K,J) != R1(J,K) )
      warning(sprintf("Asmmetry between %s and %s", N1(K,:),  N1(J,:) ))
    end
  end
end

if (diag(R1)==zeros)
  disp("Diagonal is zero")
else
  warning("Non-zero diagonal!")
end

N = length(N1)
A1 = R1 * -1 # adj. matrix where -1 shows a link
Z = zeros(N);
S = abs(sum(A1))

# Graph Laplacian repr:
#for K = 1:N
#  Z(K,K)=S(K)
#end
#LAP = A1+Z;
#
#[V D]=eig(LAP)
#  715 D(2,2)


# spy(R1)
#[ignore p]= sort(V(:,2));
#spy(R1(p,p));

#hold on;
#for K=1:length(N1)
# text(0,K, N1(K,:))
#end

# if you have graphviz wrapper then:

#draw_dot(R1)

# CSV generator

GENCSV=false
# %f float, %d int?
if GENCSV 
  for K=1:size(N1)
    disp(sprintf("%d,%s", K,N1(K,:)))
  end
  for K=1:size(N1)
    disp(sprintf("# edges for person %d named %s. ", K,N1(K,:)) )
    for J=1:size(N1)
      if (R1(K,J) == 1)
        disp(sprintf("%d,%d", K,J))
      end
    end
  end
end


# Generate GDF for Gephi:
# http://gephi.org/users/supported-graph-formats/gdf-format/
# 
disp("nodedef>name VARCHAR,label VARCHAR")
for K=1:size(N1)
  disp(sprintf("p%d,%s", K,N1(K,:)))
end
disp("edgedef>node1 VARCHAR,node2 VARCHAR")
for K=1:size(N1)
  # disp(sprintf("# edges for person %d named %s. ", K,N1(K,:)) )
  
  for J=1:size(N1)
    if (R1(K,J) == 1)
      disp(sprintf("p%d,p%d", K,J))
    end
  end
end






# lessons: symmetry (effective) of foaf:knows;  missing isn't broken; open-world assumptions. time/change. 

