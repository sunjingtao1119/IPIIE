function [x,it1,it2,er] = IPIIE(A,b,ddt,n)
%% Input
% A: Coefficient Matrix, Postive definite matrix
% b: Observation vector
% ddt: Time step
% n：Iterative termination parameters
%% Output
%  x: 
%  it1:The number of iterations of ppim-k
%  it2：The number of error corrections
%  er:Relative error
%%%%%%%%%%%%%%%%%%%%%%
if (nargin<3)
ddt=1e-1;  
n=2;
end
% A=full(A);  % Converts a sparse matrix to a dense matrix
A0=A;
b0=b;
[x1,~]=PIIE(A,b,ddt,n);
[A,Q1] = FNorm(A);
b=Q1*b;
b1=A*x1;
db0=b-b1;
it2=0;
it1=0;
db=db0;
x2=x1;
while norm(db)>1e-6
   b1=A*x1;
   db=b-b1;
   [x2,~,~,~]=PIIE(A,db,ddt,n);
   db1=b0-A0*(x1+x2);
   if norm(db1)>norm(db)
       break
   end
   x1=x1+x2;
   it2=it2+1;
   db=db1;
   if it2>10
       break;
   end
end
er=norm(x2-x1)/norm(x1);
x=x1;
end