function unit_mat=unit(mat)
% ===
% unit
%     syntax unit_mat=unit(mat)
%     mat�̗�x�N�g���̒P�ʕ����x�N�g�����x�N�g���Ƃ����s��unit_mat��Ԃ��܂�
% ===
sumMat=sqrt(sum(mat.^2));
sumMat2=ones(size(mat,1),1)*sumMat;
unit_mat=mat./sumMat2;
end