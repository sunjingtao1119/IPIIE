%利用精细积分求解矩阵的逆矩阵，要求就矩阵为正定矩阵
close all;
clc;
n = 5000;
e = ones(n,1);
A = spdiags([e 2*e e],-1:1,n,n);
x=[1:n].*0.01;
x=sin(x);


% A=full(A);
% b=sum(A,2);
b=A*x';
tic
% [x2,i,F,Q]=spim3(A,b,1e-7);
[x1,it,er]=PIIE(A,b,1,2);
toc
tic
% [x2,i,F,Q]=spim3(A,b,1e-7);
[x2,it2,er2]=PIIE_Kry(A,b,1,2);
toc
% x=pcg(A,b,1e-10,10000);
% % x=bicg(A,b);
% plot(x)
% % hold on
% % plot(x)
% % ylim([0,2])
% % er=ones(n,1)-x3;
% % hold on
% % % figure(2)
% % % plot(er)
% % % hold on 
% % plot(x)


