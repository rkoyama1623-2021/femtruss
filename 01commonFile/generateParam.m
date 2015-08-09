% ============================================
% file name:generateParam
% detail:
% �œK���݌v�����邽�߂ɁA�݌v�p�����[�^�𗐐��I�ɐ������܂��B
% 
% input:nParam(����������p�����[�^�̌�)
% output:matRatio,matParam(0~1�̃p�����[�^�A��x�N�g����݌v�p�����[�^�Ƃ���s��𐶐����܂�)
% matParam�͐݌v�p�����[�^���i�[�����s��ŁA�ȉ��̏��Ƀp�����[�^�[�������Ă��܂��B
% p,br,thb,sr,thp,   /  alpha,r
% 
%flag=1�̂Ƃ��L���v�f���f���p�ɂȂ� 
% ============================================

function [matRatio,matParam]=generateParam(nParam,flag)
% �݌v�p�����[�^�̍ő�l��^���܂��B
% �Ò�E�s�Ò�ŋ��ʂ̃p�����[�^�[
pMin=0;
pMax=0.3;
brMin=0.05;
brMax=0.6;
thbMin=0;
thbMax=pi/3;
srRatioMin=0.5;
thpMin=0;
thpMax=pi/3;


% �ȉ��̋��ʕ����͌�Œ���
if flag==1
% �L���v�f���f�����L�̃p�����[�^�[
alphaMin=0;
alphaMax=0.1;
rMin=0;%�e���q���W�̔��a
rMax=0.015/2;%�e���q���W�̔��a

matRatio=rand(7,nParam);

paramMax=[pMax,brMax,thbMax,1,thpMax,alphaMax,rMax]';
paramMin=[pMin,brMin,thbMin,srRatioMin,thpMin,alphaMin,rMin]';

temp=(paramMax-paramMin)*ones(1,nParam);
matParam2=matRatio.*temp+paramMin*ones(1,nParam);
matParam2(4,:)=matParam2(2,:).*matRatio(4,:);
matParam=matParam2;

else

matRatio=rand(5,nParam);

temp=([pMax,brMax,thbMax,1,thpMax]'-[pMin,brMin,thbMin,srRatioMin,thpMin]')*ones(1,nParam);
matParam2=matRatio.*temp+[pMin,brMin,thpMin,srRatioMin,thpMin]'*ones(1,nParam);
matParam2(4,:)=matParam2(2,:).*matParam2(4,:);%sr������
matParam=matParam2;

end




end
