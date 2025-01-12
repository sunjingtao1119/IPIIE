function x_reg = tikhonovRegularization(A, b, lambda)
% Tikhonov regularization for solving linear ill-posed problems 
% Input parameters : 
% A-system matrix 
% b - known vector 
% lambda-regularization parameter 
% Construct a regularization matrix L, usually a unit matrix
    L = eye(size(A, 2));
% forms the regularization equation
    AtA = A' * A + lambda * (L' * L);
    Atb = A' * b;
    x_reg = AtA \ Atb;
end


