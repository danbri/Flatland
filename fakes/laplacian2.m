function [LAP] = laplacian2(A);
  vdeg = sum(A);
  d = vdeg > 0;
  LAP = -A./sqrt(vdeg'*vdeg) + diag(d);
