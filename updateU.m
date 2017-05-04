function [ U] = updateU( D,U_pre,V,P,params )
% V,P fixed, seek U
%   此处显示详细说明

U = U_pre;

[M,N] = size(D);
[K,N] = size(V);

A = D * V';
B = V * V';

for k = 1:K
    h = A(:,k) - U * B(:,k) + B(k,k) * U(:,k);
    
%     temp = zeros(M,1);
%     for j = 1:K
%         if j ~= k
%             temp = U(:,j)' * h * U(:,j) + temp;
%         end
%     end
%     
%     U(:,k) = proj((h - temp) / (U(:,k)' * h));

    U(:,k) = proj(h);
    
    
    U(:,k) = U(:,k) / ((norm(U(:,k),2))+eps);

end
















end

