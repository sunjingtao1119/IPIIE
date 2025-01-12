function [A,Q] = FNorm(A)
% Matrix row norm normalization
   q=sum(abs(A),2); 
   q=q(:);
   Q=diag(1./q);
   A=Q*A;
end




