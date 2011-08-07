
# clf;
more off;
warning 'off';

P = 0.5

#[x y z] = draw_dot(R1,N1);
#for K=1:length(x)
#  text(x(K), y(K), N1(K,:))
#  disp( N1(K,:))
#end


X1 = R1
for K=1:length(R1)
  for J=1:length(R1)
    disp(sprintf("Checking link: %i %i ", K,J))
    if (X1(K,J) == 1) && (rand < P )
      disp(sprintf("Dropping link: %i %i ", K,J))
      X1(K,J) = 0
      X1(J,K) = 0
    end
  end
end

[x y z] = draw_dot(X1, N1); # not clear how to pass in labels
for K=1:length(x)
  if ( sum( X1(K,:) ) != 0) 
    text(x(K), y(K), N1(K,:)) # only label people with links
  end
end
