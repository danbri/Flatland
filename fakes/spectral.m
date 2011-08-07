n = 1000;
x = randperm(n);
gs = 450;
group1 = x(1:gs);
group2 = x(gs+1:end);
p_group1 = 0.5;
p_group2 = 0.4;
p_between = 0.1;

A(group1, group1) = rand(gs,gs) < p_group1;
A(group2, group2) = rand(n-gs,n-gs) < p_group2;
A(group1, group2) = rand(gs, n-gs) < p_between;
A = triu(A,1);
A = A + A';

# spy(A);

