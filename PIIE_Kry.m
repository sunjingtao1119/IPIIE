function [x,i,P,er] = PIIE_Kry(A,b,ddt,n)
%预处理精细积分，列范数归一化
% 参考论文，1《求解病态线性方程组的预处理精细积分法》
%          2《求解病态线性方程的一种精细格式及迭代终止准则》
% 设置默认参数
if (nargin<3)
ddt=1e-3;
n=2;
end
[A,Q1]=FNorm(A);
b=Q1*b;
% 精细精细积分求逆
F=ddt.*eye(size(A))+ddt.*(-(A.*ddt)/2+(A.*ddt)^2./6-(A.*ddt)^3./24);
% Ta=(-A*ddt)+(A*ddt)^2./2-(A*ddt)^3./6;
% N=20;
% dt=ddt/(2^N)
% Ta=(-A*ddt)+(A*ddt)^2./2-(A*ddt)^3./6+(A*ddt)^4./24;
x=F*b;
% 最大迭代次数为100
er=zeros(100,1);
P=zeros(100,1);
% Q=zeros(100,1);
i=1;
% 带收敛判断的精细积分解法，此时
while i<100
    x1=x;
    % x=x+expv_pim(ddt*2^(i-1),-A,x,30);
     x=x+expv(ddt*2^(i-1),-A,x,1e-6,10);
    er(i)=norm(x-x1)/norm(x1);
     if er(i)<1e-6
          break
     end %终止执行 for 或 while 循环
    if i>1 
          P(i)=(fix(er(i)/er(i-1))>0);
%           if P(i)==1 & P(i-1)==1  
         if n==2
             if P(i)==1 && P(i-1)==1 
                break;
             end
         end
          if n==3
              if P(i)==1 && P(i-1)==1 && P(i-2)==1 
              break; %终止执行 for 或 while 循环
              end
           end
         
            if n==4
             if P(i)==1 && P(i-1)==1 && P(i-2)==1 && P(i-3)==1 
              break; %终止执行 for 或 while 循环
             end
            end
          if n==5
             if P(i)==1 && P(i-1)==1 && P(i-2)==1 && P(i-3)==1 && P(i-4)==1 
              break; %终止执行 for 或 while 循环
             end
          end
          if n==6
             if P(i)==1 && P(i-1)==1 && P(i-2)==1 && P(i-3)==1 && P(i-4)==1 && P(i-5)==1
              break; %终止执行 for 或 while 循环
             end
          end
         if n==7
             if P(i)==1 && P(i-1)==1 && P(i-2)==1 && P(i-3)==1 && P(i-4)==1 && P(i-5)==1&& P(i-6)==1  
              break; %终止执行 for 或 while 循环
             end
         end
    end            
    i=i+1;
end
er=norm(x-x1)/norm(x1);
end