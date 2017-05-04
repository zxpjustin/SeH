function [recall, precision, max_hamm, rate] = recall_precision(Wtrue, Dhat,  max_hamm)  % micro-evaluations
%
% Input:
%    Wtrue = true neighbors [Ntest * Ndataset], can be a full matrix NxN
%    Dhat  = estimated distances
%
% Output:
%
%                  exp. # of good pairs inside hamming ball of radius <= (n-1)
%  precision(n) = --------------------------------------------------------------
%                  exp. # of total pairs inside hamming ball of radius <= (n-1)
%
%               exp. # of good pairs inside hamming ball of radius <= (n-1)
%  recall(n) = --------------------------------------------------------------
%                          exp. # of total good pairs 
% n <= max_hamm，表示当前的汉明距离（为什么用“当前”？因为要测很多个汉明距离）
% Dhat



if(nargin < 3)
    max_hamm = max(Dhat(:));
    disp(['recall_precision  ------  max_hamm：',num2str(max_hamm)]);
end
hamm_thresh = min(3,max_hamm); % 汉明距离大于或等于3的，认为是不相关的图片（但这个变量貌似并没有被用上）

[Ntest, Ntrain] = size(Wtrue);
total_good_pairs = sum(Wtrue(:));

% find pairs with similar codes
precision = zeros(max_hamm,1);
% 一个长度为max_hamm的向量，第一个数表示汉明距离最大为0的图片的准确率，第二个数表示汉明距离最大为1的图片的准确率，
% 最后一个数表示汉明距离最大为 max_hamm-1 的图片的准确率

recall = zeros(max_hamm,1);
rate = zeros(max_hamm,1);

% for n = 1:length(precision)+1
%     j = (Dhat<=((n-1)+0.00001));
%     
%     eq = find(Dhat == (n-1));
%     [num,~] = size(eq);
%     disp(['距离为 ',num2str(n-1),' 的样本共有 ',num2str(num),' 对']);
% end

for n = 1:(length(precision)+1)
    j = (Dhat<=((n-1)+0.00001));
    
%     j_size = size(j)
    
    %exp. # of good pairs that have exactly the same code
    retrieved_good_pairs = sum(Wtrue(j));
    
%     Wtrue_size = size(Wtrue)
%     Wtruej_size = size(Wtrue(j))
    
%     disp(['距离为 ',num2str(n-1),' 以下的的样本共有 ',num2str(retrieved_good_pairs),' 对']);
    
    % exp. # of total pairs that have exactly the same code
    retrieved_pairs = sum(j(:));

    precision(n,1) = retrieved_good_pairs/(retrieved_pairs+eps); % eps is a constant very near to zero
    recall(n,1)= retrieved_good_pairs/total_good_pairs;
    rate(n,1) = retrieved_pairs / (Ntest*Ntrain);
    
end

if(max_hamm == 0)
    disp('出现了 max_hamm==0 的情况');
    precision = zeros(1,1);
    recall = zeros(1,1);
    precision(1) = 0.01;
    recall(1) = 0.01;
end



% precision
% recall
% rate;

% The standard measures for IR are recall and precision. Assuming that:
% 
%    * RET is the set of all items the system has retrieved for a specific inquiry;
%    * REL is the set of relevant items for a specific inquiry;
%    * RETREL is the set of the retrieved relevant items 
% 
% then precision and recall measures are obtained as follows:
% 
%    precision = RETREL / RET
%    recall = RETREL / REL 

