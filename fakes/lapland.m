function [LAP, EIGVECS,EIGVALS] = lapland(A1);
  A2 = A1 * -1; # adj. matrix where -1 shows a link
  # A1 is our adj. matrix
  N = length(A2);
  Z = zeros(N);
  S = abs(sum(A2));
  for K = 1:N;
    Z(K,K)=S(K);
  end
  LAP = A2+Z;
  [EIGVECS, EIGVALS] = eig(LAP);
