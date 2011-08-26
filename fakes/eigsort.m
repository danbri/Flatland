function [v,d] = eigsort (x)
  length = is_square (x);
  if !(length)
    error ('Input argument is not a square matrix!\n');
  end;
  [v,d] = eig (x);
  [dd,ix] = sort (-diag (d));
  for i=1:length
    d(i,i) = - dd(i);
  end;
  v = v(:,ix)
endfunction

