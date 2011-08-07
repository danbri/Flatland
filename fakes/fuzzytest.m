## Copyright (C) 2004 Jeff Armitstead 
## 
## This file is part of Octave. 
## 
## Octave is free software; you can redistribute it and/or modify it 
## under the terms of the GNU General Public License as published by 
## the Free Software Foundation; either version 2, or (at your option) 
## any later version. 
## 
## Octave is distributed in the hope that it will be useful, but 
## WITHOUT ANY WARRANTY; without even the implied warranty of 
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU 
## General Public License for more details. 
## 
## You should have received a copy of the GNU General Public License 
## along with Octave; see the file COPYING.  If not, write to the Free 
## Software Foundation, 59 Temple Place - Suite 330, Boston, MA 
## 02111-1307, USA. 

## Author: JPA <jeffa_at_ieee_dot_org> 
## Description: Clustering of data using a (fuzzy) kmeans algorithm 
## See the excellent Pattern Classification by Duda, Hart & Stork for details 
## of algorithms. 
## 
## Demonstrate kmeans.m using example data from Duda, Hart & Stork 

w1=[ 
-5.01 -8.12 -3.68; 
-5.43 -3.48 -3.54; 
1.08 -5.52 1.66; 
0.86 -3.78 -4.11; 
-2.67 0.63 7.39; 
4.94 3.29 2.08; 
-2.51 2.09 -2.59; 
-2.25 -2.13 -6.94; 
5.56 2.86 -2.26; 
1.03 -3.33 4.33 
]; 

w2=[ 
-0.91 -0.18 -0.05; 
1.3 -2.06 -3.53; 
-7.75 -4.54 -0.95; 
-5.47 0.5 3.92; 
6.14 5.72 -4.85; 
3.6 1.26 4.36; 
5.37 -4.63 -3.65; 
7.18 1.46 -6.66; 
-7.39 1.17 6.3; 
-7.5 -6.32 -0.31 
]; 

w3=[ 
5.35 2.26 8.13; 
5.12 3.22 -2.66; 
-1.34 -5.31 -9.87; 
4.48 3.42 5.19; 
7.11 2.39 9.21; 
7.17 4.33 -0.98; 
5.75 3.97 6.65; 
0.77 0.27 2.41; 
0.9 -0.43 -8.71; 
3.52 -0.36 6.43 
]; 

sel = input("Choose data set [1,2,3]: "); 
buf=sprintf("%d",sel); 

eval(["myw=w" buf]); 
##  F          : the test data in feature space 
##  nclust     : the number of clusters to fit 
## start_cent : starting centroids, if absent data is randomly initialised to clusters 
## fuzz       : fuzzy blending ( 0 for non-fuzzy clustering ) 
## elim       : stopping criterion 
## norm       : 1=normalise raw data, 0=don't 
## metric     : 1= L1-norm, 2= L2-norm (Euclidean), ..., Inf = infinity norm. 
## verbosity  : 1=speak, 0=don't 
## graph      : 1=graph cluster norms, 0=don't 

[Cent,L,K,norm_mean,norm_std] =kmeans( myw, 5, [], 1.5, 1e-4, 0, 1, 1, 0); 

I1=find(K(:,1)); 
I2=find(K(:,2)); 
I3=find(K(:,3)); 

title(["Data Set " buf]); 
hold off 
if (length(I1) >0) 
  plot3(myw(I1,1),myw(I1,2),myw(I1,3),"+;cluster 1;") 
endif 
  
hold on 
if (length(I2) >0) 
  plot3(myw(I2,1),myw(I2,2),myw(I2,3),"+g;cluster 2;") 
endif 
if (length(I3) >0) 
  plot3(myw(I3,1),myw(I3,2),myw(I3,3),"+b;cluster 3;") 
endif 

hold off 
