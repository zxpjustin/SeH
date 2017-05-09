function [ param,P ] = doTrain_RS( D,param )
% doTrain_RS 
%  与 doTrain 唯一区别在于：用随机采样的方式处理监督数据

D = D';

[M,N] = size(D);

params = init(D,param);

outer_loop_num = params.outer_loop_num;

result.iter=[];
result.loss=[];
result.time=[];

U = params.Uinit;
V = params.Vinit;

% tic;
for i = 1:outer_loop_num
    
    P = updateP(D,V,params);
    
    U = updateU(D,U,V,P,params);
    
    V = updateV_RS(D,U,V,P,params);


    fr = norm(D-U*V, 'fro');
    loss = 1.0 / sqrt(M*N) * fr;
    result.loss=[result.loss,loss];
    
    disp(['iter ', num2str(i), ':  loss = ', num2str(loss)]);
    
%     % 若出现 NaN ，则停止
%     if isnan(loss)
%        break;
%     end
    
end



V = p1(V); % 二值化
V = (V>0);
V = V';
param.V = V;

param.B = (V);




end

