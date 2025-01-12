function val= exp_pim(A,t,N)
   if nargin<=2
       N=20;  % 默认参数
   end
    dt=t/(2^N);
    if dt>0.00001
        N=fix(log2(t/0.00001));
    end
    Ta=(A.*dt)+(A.*dt)^2/2+(A.*dt)^3/6;
    for i=1:N
        Ta=2*Ta+Ta*Ta;
    end
   val=eye(size(A))+Ta;
end

