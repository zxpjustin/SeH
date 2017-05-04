function [ R ] = initV( K,N, min,max )
% 初始化矩阵 V ，要求 V 的每一行里的数相加等于0
% 要求元素的绝对值最小为 min ,最大为 max 

% disp('initV');

% K = 5;
% N = 6;
min = 0.8;
max = 1;

n = floor(N/2);
% r = rand(K,n) * (max - min) + min; % 初始化一个元素范围为[-1,1]的随机矩阵，而且元素最小为min，最大为max
r = rand(K,n); % 初始化一个元素范围为[0,1]的随机矩阵

R = r;
if mod(N,2) ~= 0 % N是奇数
    R = [R,zeros(K,1)];
end
R = [R,-r];
for k = 1:K
    R(k,:) = R(k,randperm(N)); % 将R的每一列都打乱顺序
end
clear k;
clear r;
clear n;

% R

end

