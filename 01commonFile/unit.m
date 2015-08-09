function unit_mat=unit(mat)
% ===
% unit
%     syntax unit_mat=unit(mat)
%     matの列ベクトルの単位方向ベクトルを列ベクトルとした行列unit_matを返します
% ===
sumMat=sqrt(sum(mat.^2));
sumMat2=ones(size(mat,1),1)*sumMat;
unit_mat=mat./sumMat2;
end