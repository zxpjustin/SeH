function [ P ] = updateP( D,V,params )
% U,V fixed, seek P

delta = params.delta;
[M,~] = size(D);

% P = V * D' * ( eye(M) / (D * D' + delta * eye(M)) );
P = V * D' / (D * D' + delta * eye(M));














end

