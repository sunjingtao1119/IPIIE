function [x,i,P,er] = PIIE(A,b,ddt,n)
%% Input
% A: Coefficient Matrix, Postive definite matrix
% b: Observation vector
% ddt: Time step
% n：Iterative termination parameters
%% Output
%  x: 
%  i:The number of iterations 
%  P：The Relative error vector
%  er:Relative error
%%%%%%%%%%%%%%%%%%%%%%
if (nargin<3)
ddt=1e-3;
n=2;
end
A=full(A);
[A,Q1]=FNorm(A);
b=Q1*b;
% 精细精细积分求逆
% F=ddt.*eye(size(A))+ddt.*(-(A.*ddt)/2+(A.*ddt)^2./6-(A.*ddt)^3./24);
% F=ddt.*eye(size(A))+ddt.*(-(A.*ddt)/2)+(A.*ddt)^2./6;
F=ddt.*eye(size(A))+ddt.*(-(A.*ddt)/2);

Ta=(-A*ddt)+(A*ddt)^2./2-(A*ddt)^3./6+(A*ddt)^4./24;
x=F*b;
% 最大迭代次数为100
er=zeros(100,1);
P=zeros(100,1);
% Q=zeros(100,1);
i=1;
% 带收敛判断的精细积分解法，此时
while i<100
    x1=x;
    x=2*x+Ta*x;
    Ta=2*Ta+Ta*Ta; 
    er(i)=norm(x-x1)/norm(x1);
    % 如果误差都是很小的数，此时该收敛规则可能失效，为此提取小数点后0的个数放大误差
    % 获取精度，该步应该在第一次
     if er(i)<1e-6
          break
     end %终止执行 for 或 while 循环
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