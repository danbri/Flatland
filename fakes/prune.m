function [A2] = prune(A1,P);
if nargin == 1 
  P = 0.5;
end
A2 = A1;
for K=1:length(A2)
  for J=1:length(A2)
#    disp(sprintf("Checking link: %i %i ", K,J))
# don't unlink 1-friended ppl
    KFC = sum(A2(K,:));
    JFC = sum(A2(J,:));
    if (A2(K,J) == 1) && (rand < P ) &&   ( KFC > 1 )  && ( JFC > 1 )
#      sprintf("K=%d friend count: %d", K, KFC )
#      sprintf("J=%d friend count: %d", J, JFC )
#      sprintf("Dropping link: %d %d ", K,J )
      A2(K,J) = 0;
      A2(J,K) = 0;
      fflush(stdout);
    end
  end
end


#[x y z] = draw_dot(X1, N1); # not clear how to pass in labels
#for K=1:length(x)
#  if ( sum( X1(K,:) ) != 0) 
#    text(x(K), y(K), N1(K,:)) # only label people with links
#  end
#end
