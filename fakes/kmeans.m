## Copyright (C) 2004 Jeff Armitstead 
## 
## This file is part of Octave. 
#
## found at http://octave.1599824.n4.nabble.com/Reasonably-fast-fuzzy-kmeans-clustering-including-a-demo-script-might-live-in-statistics-td1674971.html --danbri
#  "Reasonably fast (fuzzy) kmeans clustering including a demo script, might live in statistics."
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
## Reasonably fast unsupervised clustering of data 
## 
##  [Cent,L,K,norm_mean,norm_std] = 
##  kmeans( F, nclust, start_cent, fuzz, elim, norm, metric, verbosity, graph) 
## 
## INPUTS 
## 
## F          : the test data in feature space 
## nclust     : the number of clusters to fit 
## start_cent : starting centroids, if absent data is randomly initialised to clusters 
## fuzz       : fuzzy blending ( 0 for non-fuzzy clustering ) 
## elim       : stopping criterion 
## norm       : 1=normalise raw data, 0=don't 
## metric     : 1= L1-norm, 2= L2-norm (Euclidean), ..., Inf = infinity norm. 
## verbosity  : 1=speak, 0=don't 
## graph      : 1=graph cluster norms, 0=don't 
## 
## OUTPUTS 
## 
## Cent       : the cluster centroids 
## L          : the cluster metrics for each point in feature space 
## K          : cluster membership matrix 
## norm_mean  : the normalising means 
## norm_std   : the normalising std devs 

function [Cent,L,K,norm_mean,norm_std] = kmeans(F,nclust,start_cent,fuzz,elim,norm,metric,verbosity,graph) 

  if  nargin == 2 
    start_cent=[]; 
    fuzz=0; 
    elim=1e-6; 
    norm=1; 
    metric=2; 
    verbosity=0; 
    graph=0; 
  elseif nargin == 3 
    fuzz=0; 
    elim=1e-6;     
    norm=1; 
    metric=2; 
    verbosity=0; 
    graph=0; 
  elseif nargin == 4 
    elim=1e-6; 
    norm=1; 
    metric=2; 
    verbosity=0; 
    graph=0; 
  elseif nargin == 5 
    norm=1; 
    metric=2; 
    verbosity=0;     
    graph=0; 
  elseif nargin == 6 
    metric=2; 
    verbosity=0;     
    graph=0; 
  elseif nargin == 7 
    verbosity=0;     
    graph=0;   
  elseif nargin == 8 
    graph=0; 
  elseif nargin == 9 
    ; 
  else 
    error("You must give me at least the \"data\" and no. of clusters"); 
    return 
  end 

  start_day=now(); 
  nobs=size(F,1); 
  nfeats=size(F,2); 

  if (verbosity) 
    fprintf("%d features and %d observations\n",nfeats,nobs); 
  end 

  ## Check inputs for sanity ######################### 
  if (nobs < 2*nclust) 
    error("No. of obs less than 2 * No. of clusters ??"); 
    return 
  end 
  if ((~isempty(start_cent)) & (size(start_cent,1)~=nclust | size(start_cent,2)~=nfeats)) 
    error("Starting Centroid different size to Data ??"); 
    return 
  end 
  if nclust < 2 
    error("Clusters must be >= 2 ??"); 
    return 
  end 
  if (~isempty(fuzz) & fuzz == 1 ) 
    error("Fuzzy blending must be > 1 ??"); 
    return 
  else 
    fexpon=1/(fuzz-1); 
  end 

  if isempty(fuzz) 
    fuzz=0; 
  end 
  if (isempty(elim) | elim == 0) 
    elim=1e-6; 
  end 
  if isempty(norm) 
    norm=1; 
  end 
  if isempty(metric) 
    metric=2; 
  end 
  if ( metric < 1 ) 
    error ("bad metric exponent"); 
  endif 
      
  if isempty(verbosity) 
    verbosity=1; 
  end 
  if isempty(graph) 
    graph=0; 
  end 

  ## normalize metrics ########################### 
  if norm==1 
    norm_mean=mean(F); 
    M=repmat(norm_mean,nobs,1); 
    F=F-M; 
    norm_std=std(F); 
    M=repmat(norm_std,nobs,1); 
    F=F./M; 
  else 
    norm_mean=zeros(1,size(F,2)); 
    norm_std=ones(1,size(F,2)); 
  end 
  
  K=ones(nobs,nclust); 

  ## if start_cent is empty we randomise   
  if min(size(start_cent))==0 
  
    ##initial centroids 
    lowest=min(F); 
    range=max(F)-lowest; 
    for i=1:nclust 
      Cent(i,:)=rand(1,nfeats).*range+lowest; 
    end 
  else 
    Cent=start_cent; 
  end 

  running=1; 
  pass=1; 
  max_pass = 1000; 
  
  if fuzz==0 
    ############## Use non-fuzzy kmeans algorithm ############### 
    if verbosity 
      fprintf("Using NON-fuzzy k-means algorithm\n"); 
    end 

    ##initial L2 norms 
    for i=1:nclust 
      M=repmat(Cent(i,:),nobs,1); 

      if ( metric ==2 ) 
        L(:,i)=sqrt(sum(((F-M).^2),2)); 
      elseif ( metric == 1 ) 
        L(:,i)=(sum((abs(F-M)),2)); 
      elseif ( metric == Inf ) 
        L(:,i)=max(abs(F-M)')'; 
      else 
        L(:,i)=(sum(((F-M).^metric),2)).^(1/metric); 
      endif 
    end 

    #####Start the loop   
    while running 
      if verbosity 
        fprintf("Pass no. %d\n",pass); 
      end 
      
      ## what's moving 
      for i=1:nclust 
        buf="find (("; 
        next=i+1; 
        for j=1:nclust-1 
          if (next>nclust) 
            next=1; 
          end 
          buf=sprintf("%s L(:,%d)>L(:,%d) ",buf,i,next); 
          next+=1; 
          if ((j+1)~=nclust) 
            buf=sprintf("%s | ",buf); 
          end 
        end 
        buf=sprintf("%s) & K(:,%d)) ",buf,i); 
        eval(["m(i)= length( " buf ");"]); 
      end 
    
      for i=1:nclust 
        if verbosity 
          fprintf("moving %d from cluster %d\n",m(i),i); 
        end 
      end 

      if(sum(m)==0) 
        running=0; 
      end 
      ##reallocate 
      for i=1:nclust 
        ff=find(K(:,i)); 
        K(ff,i)=zeros(size(ff)); 
      end 
    
      for i=1:nclust 
        buf="find ("; 
        next=i+1; 
        for j=1:nclust-1 
          if (next>nclust) 
            next=1; 
          end 
          buf=sprintf("%s L(:,%d)<L(:,%d) ",buf,i,next); 
          next+=1; 
          if ((j+1)~=nclust) 
            buf=sprintf("%s & ",buf); 
          end 
        end 
        buf=sprintf("%s) ",buf); 
        eval(["II= " buf ";"]); 
        K(II,i)=ones(size(II)); 
      end 
  
      ##centroids 
      for i=1:nclust 
        Cent(i,:)=mean(F(find(K(:,i)),:)); 
      end 
    
      ##L2 norms 
      for i=1:nclust 
        M=repmat(Cent(i,:),nobs,1); 

        if ( metric ==2 ) 
          L(:,i)=sqrt(sum(((F-M).^2),2)); 
        elseif ( metric == 1 ) 
          L(:,i)=(sum((abs(F-M)),2)); 
        elseif ( metric == Inf ) 
          L(:,i)=max(abs(F-M)')'; 
        else 
          L(:,i)=(sum(((F-M).^metric),2)).^(1/metric); 
        endif 
      end 
      
      pass+=1; 
      if ( pass > max_pass ) 
        error("exceeded maximum number of iterations"); 
      endif 
    end #while running 
  else 
    ############## Use fuzzy kmeans algorithm ############### 
    if verbosity 
      fprintf("Using fuzzy k-means algorithm\n"); 
    end 
    
    Cold=Cent; 

    while running 
      if verbosity 
        fprintf("Pass no. %d\n",pass); 
      end 
  
      ##L2 norms 
      for i=1:nclust 
        M=repmat(Cent(i,:),nobs,1); 

        if ( metric ==2 ) 
          L(:,i)=sqrt(sum(((F-M).^2),2)); 
        elseif ( metric == 1 ) 
          L(:,i)=(sum((abs(F-M)),2)); 
        elseif ( metric == Inf ) 
          L(:,i)=max(abs(F-M)')'; 
        else 
          L(:,i)=(sum(((F-M).^metric),2)).^(1/metric); 
        endif 
        
      end 
  
      ## Membership probabilities 
      temp=(1./L).^(fexpon); 
      nmemprob=temp./repmat(sum(temp,2),1,nclust); 
    
      ##new centroids 
      for i=1:nclust 
        parr=repmat(nmemprob(:,i),1,nfeats); 
        Cent(i,:)=sum((parr.^fexpon).*F)./sum(parr.^fexpon); 
      end 
      ## Stopping crit 

      nm=sqrt(sum(sum((Cent - Cold).^2))); 
      if nm < elim 
        running=0; 
      end 
    
      Cold=Cent; 
    
      pass+=1; 
      if ( pass > max_pass ) 
        error("exceeded maximum number of iterations"); 
      endif 
    end #while running 

    ## Calculate the other things 
  
    K=zeros(nobs,nclust); 
    [m,im]=max(nmemprob'); 

    ##euclidean centroids 
    for i=1:nclust 
      II=find(im==i); 
      if length(II)==1 
        Cent(i,:)=F(II,:); 
      else 
        Cent(i,:)=mean(F(II,:)); 
      end 
    end 

    ##Euclidean L2 norms 
    for i=1:nclust 
      M=repmat(Cent(i,:),nobs,1); 

      if ( metric ==2 ) 
        L(:,i)=sqrt(sum(((F-M).^2),2)); 
      elseif ( metric == 1 ) 
        L(:,i)=(sum((abs(F-M)),2)); 
      elseif ( metric == Inf ) 
        L(:,i)=max(abs(F-M)')'; 
      else 
        L(:,i)=(sum(((F-M).^metric),2)).^(1/metric); 
      endif 
    end 
  
    for i=1:nclust 
      II=find(im==i); 
      K(II,i)=ones(size(II))'; 
    end 
  
  end ##Fuzzy kmeans algorithm 
  
  if verbosity 
    fprintf('Elapsed time= %f\n',(now()-start_day)*24*60*60); 
    
    fprintf("Cluster metric norms are:\n"); 
    if ( metric ==2 ) 
      lnm=sqrt(sum(L.^2)); 
    elseif ( metric == 1 ) 
      lnm=sum(abs(L)); 
    elseif ( metric == Inf ) 
      lnm=max(abs(L))'; 
    else 
      lnm=(sum(L.^metric)).^(1/metric); 
    endif 

    for i=1:length(lnm) 
      fprintf("%f\t",lnm(i)); 
    end 
    fprintf("\n"); 
  
    ##fprintf("\nTotal norm= %f %f\n",norm(lnm),norm(L,"fro")); 
  end 

  if graph 
    ## visualise cluster metrics 
    
    if (nclust==2) 
      ## easy 
      
      hold off; 
      xlabel("Norm 1"); 
      ylabel("Norm 2"); 
      plot(L(find(K(:,1)),1),L(find(K(:,1)),2),"r*;Clust 1;"); 
      hold on; 
      plot(L(find(K(:,2)),1),L(find(K(:,2)),2),"b*;Clust 2;"); 
      hold off; 
    end 
  
    if (nclust==3) 
      ## tricky 
      
      I=find(K(:,1)); 
      II=find(K(:,2)); 
      III=find(K(:,3)); 
      hold off; 
      polar([2*pi/3 2*pi/3 4*pi/3 4*pi/3 2*pi 2*pi],[0 10 0 10 0 10],"-o"); 
      axis('square'); 
      legend('off'); 
      hold on; 
      ##   
      [theta,r]=cart2pol(L(I,1),L(I,2)); 
      theta=theta/(pi/2)*(2*pi/3); 
      polar(theta,r,"*r"); 
      [theta,r]=cart2pol(L(II,1),L(II,2)); 
      theta=theta/(pi/2)*(2*pi/3); 
      polar(theta,r,"*b"); 
      [theta,r]=cart2pol(L(III,1),L(III,2)); 
      theta=theta/(pi/2)*(2*pi/3); 
      polar(theta,r,"*g"); 
      ## 
      [theta,r]=cart2pol(L(I,2),L(I,3)); 
      theta=theta/(pi/2)*(2*pi/3)+(2*pi/3); 
      polar(theta,r,"*r"); 
      [theta,r]=cart2pol(L(II,2),L(II,3)); 
      theta=theta/(pi/2)*(2*pi/3)+(2*pi/3); 
      polar(theta,r,"*b"); 
      [theta,r]=cart2pol(L(III,2),L(III,3)); 
      theta=theta/(pi/2)*(2*pi/3)+(2*pi/3); 
      polar(theta,r,"*g"); 
      ## 
      [theta,r]=cart2pol(L(I,3),L(I,1)); 
      theta=theta/(pi/2)*(2*pi/3)+(4*pi/3); 
      polar(theta,r,"*r"); 
      [theta,r]=cart2pol(L(II,3),L(II,1)); 
      theta=theta/(pi/2)*(2*pi/3)+(4*pi/3); 
      polar(theta,r,"*b"); 
      [theta,r]=cart2pol(L(III,3),L(III,1)); 
      theta=theta/(pi/2)*(2*pi/3)+(4*pi/3); 
      polar(theta,r,"*g"); 
      ## 
      hold off; 
    end 

    if ( nclust > 3 ) 
      ## .er... 
      fprintf("Can't visualise metrics for nclust > 3.\n"); 
    endif 
    
  end 

endfunction 

