rdfweb;


# This script runs through a small affinity matrix of people-to-people links, generates new subsets by removing arbitrary connections.
# Then we draw with graphviz (see nearby files), and explore via graph laplacian representation and its eigenvectors/values.
# 
# Bug?: eig() isn't returning sorted and we should be sorting the eigenvectors by the eigenvalues so we can e.g. find the
# second smallest eigenvalue and from that the corresponding vector?

# Refs:
# http://en.wikipedia.org/wiki/Laplacian_matrix
# http://en.wikipedia.org/wiki/Algebraic_connectivity#The_Fiedler_vector aka http://en.wikipedia.org/wiki/Fiedler_vector
# 
# "The algebraic connectivity of a graph G is the second-smallest eigenvalue of the Laplacian matrix of G.[1] 
# This eigenvalue is greater than 0 if and only if G is a connected graph. This is a corollary to the fact that the number 
# of times 0 appears as an eigenvalue in the Laplacian is the number of connected components in the graph. The magnitude 
# of this value reflects how well connected the overall graph is, and has been used in analysing the synchronizability of networks."


# 'Adjacency matrix from early FOAF crawl, pruned of links, 0.7 probability of link drop when each end has 2+ links. Re-ordered using 2nd smallest eigenvector of the graph laplacian.'

# todo: install ghostscript (on osx on this version of Octave, at least; otherwise jpeg writer fails)

fid = fopen('tmp/_report.html','w'); # or 'a' appends

warning("off"); # :( re 'ft_render: skipping missing glyph for character ` '
more off;

# draw_dot(R1, N1);
  fprintf(fid, ["<h2>Link Graph</h2>\n"] );

RUNS=1

for (K = 1:RUNS);

  figure();
  # first figure
  #subplot(221)
  disp(sprintf("Run no. %d :",K));
  R2 = prune(R1,0.35);
  draw_dot(R2, cellstr(N1));
  title(sprintf("Reduced rdfweb.org fig %d(a)", K));  # draw matrix chart
  #subplot(222)
  fig_no = gcf;
  fn=sprintf("tmp/_foaf_gviz_%i.jpg",fig_no);
  saveas(fig_no, fn , 'jpg' );
  fprintf(fid, [ sprintf("<img width='600' src='../%s' />\n",fn)  ] );

  figure();
  L = laplacian(R2);

  [V D] = eig(L);

#  [V D] = eigsort(L);


  # http://octave.1599824.n4.nabble.com/eig-function-td1609306.html


  # http://www.cs.purdue.edu/homes/dgleich/demos/matlab/spectral/spectral.html
  # D(2,2);
  [ignore p] = sort(V(:,2));
  spy(R2(p,p));
  title(sprintf("Reduced rdfweb.org fig %d(b) - sorted adjacency matrix", K));  # draw matrix chart
  for J=1:length(N1)
    NAME = N1(p(J),:);
    text(1,J,NAME);
    text( J,1,NAME, 'Rotation', -90);
    xlabel('people');
    ylabel('people');
  end
  fig_no = gcf;
  fn=sprintf("tmp/_foaf_adjgrid_%i.jpg",fig_no);
  saveas(fig_no, fn , 'jpg' );
  fprintf(fid, [ sprintf("<img width='600' src='../%s' />\n",fn)  ] );
  



  #subplot(223)
  figure();
  subplot(211);
 [foo,neworder] = sort(V(:,2));
#  plot(sort(V(:,2)), '.-');
  plot([foo],'.-');
  title(sprintf("Reduced rdfweb.org fig %d(c) - 2nd smallest eigenvector, sorted values", K));  # draw matrix chart
  hold on;
  for J=1:length(N1)
    NAME = N1(p(J),:);
#    disp(NAME)
#    text(1,J,NAME);
    text( J,foo(J),NAME, 'Rotation', -90);
  end

  subplot(212);
  #  bar(1:37,sort(diag(D)))
  bar(1:37,diag(D))
  zeroish = sum(sort(diag(D))(1:5) < 0.00001);
  # hold on;
  title( sprintf("No. of zero-ish eigenvals: %i", zeroish) );
  # sort(diag(D))(1:5)


  fig_no = gcf;
  fn=sprintf("tmp/_foaf_spectral_%i.jpg",fig_no);
  saveas(fig_no, fn , 'jpg' );
  fprintf(fid, [ sprintf("<img width='600' src='../%s' />\n",fn)  ] );
  
  fprintf(fid, [ sprintf("<hr/>\n\n")] );


end



  # hold on;
  # spy(R2(p,p));
  # hold on;
fclose(fid);
