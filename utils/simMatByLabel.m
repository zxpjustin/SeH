function [ S ] = simMatByLabel( test_label, train_label )
% 根据标签，返回相似度矩阵
% 

[testNum,~] = size(test_label);
[trainNum,~] = size(train_label);

S = zeros(testNum, trainNum);
for i = 1:testNum
    for j = 1:trainNum
        if test_label(i,1) == train_label(j,1)
            S(i,j) = 1;
        end
    end
end


end

