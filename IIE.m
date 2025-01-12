function [x,i,P,er] = IIE(A,b,ddt,n)
%% Input
% A: Coefficient Matrix, Postive definite matrix
% b: Observation vector
% ddt: Time step
% n：Iterative termination parameters
%% Output
%  x: 
%  i:The number of iterations 
%  P:The Relative error vector
%  er:Relative error
%%%%%%%%%%%%%%%%%%%%%%
if (nargin<3)
ddt=1e-3;
n=2;
end
F=ddt.*eye(size(A))+ddt.*(-(A.*ddt)/2+(A.*ddt)^2./6-(A.*ddt)^3./24);
Ta=(-A*ddt)+(A*ddt)^2./2-(A*ddt)^3./6+(A*ddt)^4./24;
x=F*b; % Initial value
er=zeros(100,1);
P=zeros(100,1);
i=1;
while i<100
    x1=x;
    x=2*x+Ta*x;
    Ta=2*Ta+Ta*Ta; 
    er(i)=norm(x-x1)/norm(x1);
    if er(i)<1e-6
          break
    end 
    if i>1 
          P(i)=(fix(er(i)/er(i-1))>0);
         if n==2
             if P(i)==1 && P(i-1)==1 
                break;
             end
         end
         if n==3
              if P(i)==1 && P(i-1)==1 && P(i-2)==1 
              break; 
              end
          end
         
            if n==4
             if P(i)==1 && P(i-1)==1 && P(i-2)==1 && P(i-3)==1 
              break;
             end
            end
          if n==5
             if P(i)==1 && P(i-1)==1 && P(i-2)==1 && P(i-3)==1 && P(i-4)==1 
              break; 
             end
          end
          if n==6
             if P(i)==1 && P(i-1)==1 && P(i-2)==1 && P(i-3)==1 && P(i-4)==1 && P(i-5)==1
              break;
             end
          end
         if n==7
             if P(i)==1 && P(i-1)==1 && P(i-2)==1 && P(i-3)==1 && P(i-4)==1 && P(i-5)==1&& P(i-6)==1  
              break; 
             end
         end
    end            
    i=i+1;
end
er=norm(x-x1)/norm(x1);
end