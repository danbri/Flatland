function [v,d] = eigsort (x)
  length = issquare(x);
  if !(length)
    error ('Input argument is not a square matrix!\n');
  end;

   #
  [v,d] = eig (x);
#   v = fliplr(v); 
#   d = flipud(fliplr(d));  % or use:  d = diag(flipud(diag(d))) 
  [dd,ix] = sort (-diag (d));
  for i=1:length
    d(i,i) = - dd(i);
  end;
  v = v(:,ix)

# 

endfunction

