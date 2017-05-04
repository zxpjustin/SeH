function [ db_data, db_label ] = loadData( db_name, sampleNum )
% 加载 数据 与 标签
% db_name：数据集名称
% sampleNum：选取的样本数量
% evalMethod：评价方式


% % 为了加载文件，先跳到当前函数所在的目录（改函数返回之后别忘了再跳回去）
% p1 = mfilename('fullpath');
% i=findstr(p1,'\');
% p1=p1(1:i(end));
% cd(p1);
% cd('..')
% 
% % addpath('../');
% addpath('..');

% load dataset
load cnn_1024d_Caltech-256.mat;
db_datalabel = feat;
db_data = db_datalabel(1:sampleNum, 1:end);

rgbImgList = rgbImgList(1:sampleNum);
[dataNum,~] = size(rgbImgList);
db_label = zeros(dataNum,1);
for i = 1:dataNum
    strcell = rgbImgList(i,1);
    str = strcell{1};
    db_label(i,1) = str2num(str(1:3));
end



db_data = db_data(1:sampleNum,:);
db_label = db_label(1:sampleNum,:);

db_data_size = size(db_data)
db_label_size = size(db_label)

disp('数据加载完毕...');




end

