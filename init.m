function [ params ] = init( D,param )
%INIT 此处显示有关此函数的摘要
%   此处显示详细说明

if param.randomSample == 0
    params.outer_loop_num = 120;
elseif param.randomSample == 1
    params.outer_loop_num = 80;
end
params.inner_loop_num = 100;

% params.outer_loop_num = 2;
% params.inner_loop_num = 2;

[M,N]=size(D);

params.db_name = param.db_name;
% params.method = param.method;
params.sampleNum = param.sampleNum;

params.alpha = param.alpha;
params.beta = param.beta;
params.epsilon = param.epsilon;
params.mu = param.mu;
params.lambda = param.lamda;
params.gamma = param.gamma;
params.delta = param.delta;

params.K = param.nbits;
K = params.K;

% params.step = 0.01;
% params.step = 0.005; % bit位数较大时，需要使用这个较小的步长

params.step = 0.001;
% params.step = 0.0002;
% params.step = -(5e-05) * K + 0.0074;  % 根据K变化的步长

updateV_step = params.step


% 不使用随机采样时用 S
if param.randomSample == 0
    params.S = param.S;
    S = params.S; % S矩阵（即：WtrueTrainTraining，是个对称阵，对角线元素必全为1），表示训练集内部的相似程度
    A = zeros(N,N);
    for n = 1:N
        A(n,n) = sum(S(n,:));
    end

    L = A - S;
    params.L = L;

    O = ones(N,N) - S;
    params.O = O;
    
    params.randomSampleNum = 0; % SemiNMFH_supervised 方法中没用到 randomSampleNum，这里设置为0（反正也没用）
end

% 使用随机采样时用 train_label
if param.randomSample == 1
    params.train_label = param.train_label;
    params.randomSampleNum = param.randomSampleNum; % 每次小迭代的采样数量
end


Uinit = rand(M,K);
for n = 1:K
    Uinit(:,n) = Uinit(:,n) ./ norm(Uinit(:,n),2); % 列归一化
end


% Vinit = rand(K,N) * 2 - 1; % 初始化一个元素范围为[-1,1]的随机矩阵
Vinit = initV(K,N);  % 初始化一个元素范围为[-1,1]的随机矩阵,并且每一行相加为0

params.Uinit = Uinit;
params.Vinit = Vinit;

end

