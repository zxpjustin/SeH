function [ V ] = updateV( D,U,V_pre,P,params )
% U,P fixed, seek V
%   此处显示详细说明

[M,N] = size(D);
[M,K] = size(U);

V = V_pre;

inner_loop_num = params.inner_loop_num; % 内层迭代次数
alpha = params.alpha;
beta = params.beta;
epsilon = params.epsilon;
mu = params.mu;
lambda = params.lambda;
gamma = params.gamma;
step = params.step; % 步长
L = params.L; % 训练集样本的同类矩阵
O = params.O; % 训练集样本的异类矩阵

A = U' * U;
B = U' * D;
C = P * D;




for i = 1:inner_loop_num
    
    G_lambda = zeros(K,N);
    for k = 1:K
        raw_sum = 0;
        for n = 1:N
            raw_sum = V(k,n) + raw_sum;
        end
        if raw_sum > 0 
            G_lambda(k,:) = zeros(1,N) + 1;
        else
            G_lambda(k,:) = zeros(1,N) - 1;
        end
    end

    G_gamma = zeros(K,N);
    for k = 1:K
        for n = 1:N
            if V(k,n) >= 0 
                G_gamma(k,n) = 2 * (V(k,n) - 1);
            else
                G_gamma(k,n) = 2 * (V(k,n) + 1);
            end
        end
    end
    
    gradient = (2*A*V-2*B) + lambda*G_lambda + gamma*G_gamma + epsilon*2*(V-C) + mu*alpha*2*V*L + mu*beta*2*V*O;
    
%     % 输出内层循环的情况
%     fr2V = norm(V, 'fro');
%     fr = norm(D-U*V, 'fro');
%     loss = 1.0 / sqrt(M*N) * fr;
%     disp(['第',num2str(i),'次内层循环完成， loss = ',num2str(loss),'  fr2V = ',num2str(fr2V)]);
    
    V = V - step * gradient;
    
end









end

