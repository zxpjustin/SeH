function [ param,P ] = doTrain( D,param )
%DOTRAIN training stage for SeH
% D: The original feature matrix.

D = D';

[M,N] = size(D);

% fr2D = norm(D, 'fro')


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
    
    V = updateV(D,U,V,P,params);


    % record results
    result.iter=[result.iter,i];
    fr = norm(D-U*V, 'fro');
    loss = 1.0 / sqrt(M*N) * fr;
    result.loss=[result.loss,loss];
    
    disp(['iter ', num2str(i), ':  loss = ', num2str(loss)]);
    
%     % Èô³öÏÖ NaN £¬ÔòÍ£Ö¹
%     if isnan(loss)
%        break;
%     end
    
end












V = p1(V); % Binarization.
V = (V>0);
V = V';
param.V = V;

param.B = (V);




end

