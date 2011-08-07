# http://en.wikipedia.org/wiki/Laplacian_matrix
# 'Adjacency matrix from early FOAF crawl, pruned of links, 0.7 probability of link drop when each end has 2+ links. Re-ordered using 2nd smallest eigenvector of the graph laplacian.'


warning("off"); # :( re 'ft_render: skipping missing glyph for character ` '
more off;

# draw_dot(R1, N1);

for (K = 1:4);
  disp(sprintf("Run no. %d :",K));
  R2 = prune(R1,0.35);

  draw_dot(R2, N1);
  title(sprintf("Reduced rdfweb.org fig %d(a)", K));  # draw matrix chart

  figure();
  L = laplacian(R2);
  [V D] = eig(L);
  D(2,2)
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
  
  figure();
  plot(sort(V(:,2)), '.-');
  title(sprintf("Reduced rdfweb.org fig %d(c) - 2nd smallest eigenvector, sorted values", K));  # draw matrix chart
  
end




  # hold on;
  # spy(R2(p,p));
  # hold on;
