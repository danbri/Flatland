
rdfweb;

# http://en.wikipedia.org/wiki/Laplacian_matrix
# 'Adjacency matrix from early FOAF crawl, pruned of links, 0.7 probability of link drop when each end has 2+ links. Re-ordered using 2nd smallest eigenvector of the graph laplacian.'

# todo: install ghostscript (on osx on this version of Octave, at least; otherwise jpeg writer fails)

fid = fopen('tmp/_report.html','w'); # or 'a' appends

warning("off"); # :( re 'ft_render: skipping missing glyph for character ` '
more off;

# draw_dot(R1, N1);
  fprintf(fid, ["<h2>Link Graph</h2>\n"] );

for (K = 1:10);

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
  fig_no = gcf;
  fn=sprintf("tmp/_foaf_adjgrid_%i.jpg",fig_no);
  saveas(fig_no, fn , 'jpg' );
  fprintf(fid, [ sprintf("<img width='600' src='../%s' />\n",fn)  ] );
  



  #subplot(223)
  figure();
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
