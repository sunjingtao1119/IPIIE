function [x,it1,it2,er] = IPIIE_krv(A,b,ddt,n)
if (nargin<3)
ddt=1e-1;  
n=2;
end
[x1,~]=PIIE_Kry(A,b,ddt,n);
% [A,Q1] = FNorm(A);
% b=Q1*b;
b1=A*x1;
db=b-b1;
it2=0;
it1=0;
er=norm(db);
while norm(db)>1e-6
   b1=A*x1;
   db=b-b1;
   x2=PIIE_Kry(A,db,ddt,2);
   x1=x1+x2;
   it2=it2+1;
   er(it2)=norm(db);
   if it2>100
       break;
   end
end
% er=norm(x2-x1)/norm(x1);
x=x1;
end