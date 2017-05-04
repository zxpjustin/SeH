function exp_data = construct_data(db_name, db_data, param, db_label, db_data_name)


% 1,000 data points are random selected from the whole data set 
% as the queries, and the remaining is used to form the gallery database
% and treated as the targets for search. A nominal threshold of the average 
% distance to the 50th nearest neighbor is used to determine whether a 
% database point returned for a given query is considered a true positive.


% choice = param.choice;
% parameters
averageNumberNeighbors = 50;    % ground truth is 50 nearest neighbor

% construct data
fprintf('starting construct %s database\n\n', db_name);

num_test = 1000; 

% split up into training and test set
[ndata, D] = size(db_data) % 目测当前是每行一个样本,每列一个特征


R = randperm(ndata);  % ndata为样本数，R为长度为ndata的一维向量，其值为 乱序 的1到ndata    

random_R.R = randperm(param.sampleNum, param.sampleNum);


R = random_R.R; 
R_size = size(R)

% 将随机选取的测试集固定下来
% save('SemiNMFH_supervised/random_R.mat','R');
% random_R = load('SemiNMFH_supervised/random_R.mat');
% R = random_R.R;
% ok = 1

% num_test
test_data = db_data(R(1:num_test), :); % 即：用随机的 num_test 个样本作测试集

test_label = db_label(R(1:num_test), :); % num_test 个测试样本对应的标签

test_ID = R(1:num_test);
R(1: num_test) = [];
train_data = db_data(R, :);
train_label = db_label(R, :);

train_ID = R;
num_training = size(train_data, 1)


% define ground-truth neighbors (this is only used for the evaluation):
R = randperm(num_training); % R变成了训练样本集大小的乱序向量了

DtrueTraining = distMat(train_data(R(1:100), :), train_data); % sample 100 points to find a threshold
Dball = sort(DtrueTraining, 2);    % DtrueTraining sort by row （矩阵的每行独自排序）
clear DtrueTraining;
Dball = mean(Dball(:, averageNumberNeighbors));

% scale data so that the target distance is 1
train_data = train_data / Dball;
test_data = test_data / Dball;
Dball = 1;


WtrueTestTraining = simMatByLabel(test_label,train_label);




if param.randomSample == 0
    WtrueTrainTraining = simMatByLabel(train_label,train_label);
    exp_data.WtrueTrainTraining = WtrueTrainTraining;
end


% generate training ans test split and the data matrix
XX = [train_data; test_data];
% XX 是 N*M 的。


% num_training = size(train_data, 1);
num_testing = size(test_data, 1);



% % center the data, VERY IMPORTANT
% sampleMean = mean(XX,1);
% XX = (double(XX)-repmat(sampleMean,size(XX,1),1));


% XX
% normalize the data
XX_normalized = normalize1(XX);


exp_data.train_data = XX(1:num_training, :);
exp_data.test_data = XX(num_training+1:end, :);
exp_data.db_data = XX;

if strcmp(db_name, 'LabelMe_gist-512')
    exp_data.trainLabelIndex = trainLabelIndex;
    exp_data.testLabelIndex = testLabelIndex;
else
    exp_data.train_label = train_label;
    exp_data.test_label = test_label;
    
    if exist('param.isFindPic', 'var') && param.isFindPic == 1
        exp_data.train_data_name = train_data_name;
        exp_data.test_data_name = test_data_name;
    end

end



exp_data.train_data_norml = XX_normalized(1:num_training, :);
exp_data.test_data_norml = XX_normalized(num_training+1:end, :);
exp_data.db_data_norml = XX_normalized;

exp_data.train_ID = train_ID;
exp_data.test_ID = test_ID;

exp_data.WTT = WtrueTestTraining;




fprintf('constructing %s database has finished\n\n', db_name);