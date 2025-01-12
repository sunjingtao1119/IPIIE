clear;
close all;
clc;
addpath('.\regu\') % Add matlab regularization
N=50;
[A,b,x] = blur(N,6,3);
%tikhonov Regularization method
lambda=1e-10 ; % Regularization parameter
x1= tikhonovRegularization(A,b,lambda);
% x1= tikhonov(A,b,lambda);
[U,s,V]=csvd(A);
% lambda= l_curve(U,s,b);
% x1= tikhonov(U,s,V,b,lambda);
lambda_l = l_curve(U,s,b,'tsvd');
x4=tsvd(U,s,V,b,lambda_l);
b=A'*b;
A=A'*A;
[x2,~,~,~] =PIIE(A,b,0.001,2);
[x3,~,~,~] =IPIIE(A,b,0.001,2);
er1=norm(x-x1)/norm(x)
er2=norm(x-x2)/norm(x)
er3=norm(x-x3)/norm(x)
er4=norm(x-x4)/norm(x)
%%
figure('Position',[100, 100, 400, 300])
% title()
imagesc(reshape(x,N,N))
colorbar
% filename="x1";
% print( filename,'-dtiffn','-r300'); 
%%
figure('Position',[100, 100, 400, 300])
% title()
imagesc(reshape(b,N,N))
clim([0,4])
colorbar

figure('Position',[100, 100, 400, 300])
imagesc(reshape(x1,N,N))
clim([0,4])
colorbar
% filename="TR1";
% print( filename,'-dtiffn','-r300'); 
figure('Position',[100, 100, 400, 300])
imagesc(reshape(x2,N,N))
clim([0,4])
colorbar
% filename="GPPII1";
% print( filename,'-dtiffn','-r300'); 
figure('Position',[100, 100, 400, 300])
imagesc(reshape(x3,N,N))
clim([0,4])
colorbar
figure('Position',[100, 100, 400, 300])
imagesc(reshape(x4,N,N))
clim([0,4])
colorbar

rmpath('.\regu\') % Add matlab regularization

