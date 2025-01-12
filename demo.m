clear
close all
clc
n1=10;
H=hilb(n1);  % Hilbert matrix
Z=zeros(size(H));
I=eye(size(H));
A=[Z,I;-H,0.1.*I];
