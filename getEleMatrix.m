function [ eleMatrix ] = getEleMatrix( index, N )
%GETELEMATRIX 生成一个初等矩阵
%   index 是一个行向量
% 例：index = [1,2,4]，N = 6；则：
%     eleMatrix = 
%     [[1,0,0,0,0,0]
%      [0,1,0,0,0,0]
%      [0,0,0,1,0,0]]

[~,r] = size(index);
eleMatrix = zeros(r,N);
for i = 1:r
    eleMatrix(i,index(i)) = 1;
end


end

