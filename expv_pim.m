function w= expv_pim( t, A, v, m )
    % 基于精细积分的krylov子空间指数矩阵算法
    beta=norm(v);
    e1=zeros(m,1);
    e1(1)=1;
    v1=v./beta;
    n=size(A,1);
    V = zeros(n,m+1); 
    V(:,1)=v1;
    H=zeros(m+1,m+1);
    % The Arnoldi progrss
    for j=1:m
        w=A*V(:,j);
        for i=1:j
            H(i,j)=w'*V(:,i);
            w=w-H(i,j).*V(:,i);
        end
        s=norm(w);
        mb=m;
        if s<1e-6
            break;
        end
        H(j+1,i)=norm(w);
        V(:,j+1)=w./s;
    end
    H=H(1:mb,1:mb);
    w=beta.*V(:,1:mb)*exp_pim(H.*t,1)*e1;
end


