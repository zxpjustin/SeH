function [ B ] = doTest( testSet,P,param )
%DOTEST 此处显示有关此函数的摘要
%   此处显示详细说明

D = testSet';

% [M,N] = size(D);

V = P * D;

V = p1(V); % 二值化
V = (V>0);
V = V';

% B = compactbit(V);
B = (V);

end

