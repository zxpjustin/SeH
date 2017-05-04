
clear all;

addpath('./utils/');

db_name = 'cnn_1024d_Caltech-256';
param.sampleNum = 5090;  % the number of samples selected
param.db_name = db_name;

param.randomSample = 0;  % Randomly sample if this parameter is 1, otherwise if 0.

if param.randomSample == 1
    param.randomSampleNum = 1000;
end

[db_data, db_label] = loadData(db_name, param.sampleNum);


exp_data = construct_data(db_name, double(db_data), param, db_label);

if param.randomSample == 0
    param.S = exp_data.WtrueTrainTraining;
end


WtrueTestTraining = exp_data.WTT;


train_data = exp_data.train_data;
test_data = exp_data.test_data;
train_label = exp_data.train_label;
% test_label = exp_data.test_label;

db_data = exp_data.db_data;

NMFparam = param;

% parameters
NMFparam.mu=1;
NMFparam.epsilon=1.0e-03;
NMFparam.gamma=1.0e-02; 
NMFparam.lamda=10.0e-01; 
NMFparam.delta=5.0e-01; 
NMFparam.alpha=0.03; 
NMFparam.beta=2e-05;

% hash codes length
NMFparam.nbits=64;

        
[trnNum,~] = size(train_data);
[tstNum,~] = size(test_data);

if param.randomSample == 0
    [NMFparam,NMF_P] = doTrain(db_data(1:trnNum,:), NMFparam);
elseif param.randomSample == 1
    NMFparam.train_label = train_label;
    [NMFparam,NMF_P] = doTrain_RS(db_data(1:trnNum,:), NMFparam);
else
    error('Undefined parameter.');
end

B_trn = NMFparam.B;
B_tst = doTest(db_data(trnNum+1:end,:),NMF_P,NMFparam);
clear db_data train_data test_data train_label test_label NMFparam;


B_trn=compactbit(B_trn);
B_tst=compactbit(B_tst);
% compute Hamming metric and compute recall precision
Dhamm = hammingDist(B_tst, B_trn);


clear B_tst B_trn;

   
[recall, precision, max_hamm,~] = recall_precision(WtrueTestTraining, Dhamm);       
        
mAP = area_RP(recall, precision)




