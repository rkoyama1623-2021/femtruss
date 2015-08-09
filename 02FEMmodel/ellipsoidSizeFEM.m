function [plAx,V,mat,myDelta]=ellipsoidSizeFEM(sr,thp,br,thb,pb,alphaLeg,phi,theta,psi,param1,param2,param3,option,varargin)
% ======================================================================
% ����ȉ~�̂̎厲����plAx,�厲�����x�N�g��V,���R�r�s��J�����߂܂�
% syntax:
%    [plAx,V,J]=ellipsoidSizeFEM(sr,thp,br,thb,pb,alphaLeg,phi,theta,psi,param1,param2,param3,option)
%     option:'p1','p2','w1','w2'
%     'p1':�p�x�S���Ȃ��̕��i�ψʂ̉���ȉ~��[m]
%     'p2':�p�x���S�������ꍇ�̕��i����ȉ~��[m]
%     'w1':���i�S���Ȃ��̎p����]�̉���ȉ~��[deg]
%     'w2':���i�S������̎p����]�̉���ȉ~��[deg]
% ======================================================================

global node;	global yoso;
global dof;
global K;		global F;
global K0;	global F0;
global delta;

% --------------------------  ���R�r�s�񐶐�   ------------------------- %
[sb,bb,sp]=stwertPlatform(sr,thp,br,thb,pb,phi,theta,psi);%stwertPlatform��`�悷�邽�߁B�Ȃ��Ă�FEM�̌v�Z�͉\�B
%�m�[�h�Ɨv�f�̐���
generateYosoAndNode2(sr,thp,br,thb,pb,alphaLeg,phi,theta,psi,param1,param2,param3);

mat=zeros(6,6);%���x�}�g���b�N�X�̉��n
nNode=size(node,2);
nNodeVertual=nNode-5;
M=zeros(dof*nNode,dof*nNodeVertual);
matPlate=zeros(6,6,6);
for nodei=1:6
% �v���b�g�t�H�[�����S�Əo�̓����N�̊Ԃ̊֌W��^������W
    si1=sp(1,nodei);
    si2=sp(2,nodei);
    si3=sp(3,nodei);

    matPlate2=[0 si3 -si2;-si3 0 si1;si2 -si1 0];
    matPlate1=[eye(3) matPlate2;zeros(3) eye(3)];
    matPlate(:,:,nodei)=matPlate1;
    M(1+dof*(nodei-1):dof*nodei,1:6)=matPlate1;
end
M(1+dof*6:dof*nNode,1+dof:dof*nNodeVertual)=eye(dof*(nNodeVertual-1));


mydelta=zeros(size(F,1),6);
for iLeg=1:6
    %�L���v�f�@�̏���
    nNode=length(node(1,:));
    nYoso=length(yoso(1,:));
    % �΂˒萔�̏d�ˍ��킹
    K=zeros(dof*nNode,dof*nNode);
    for yosoi=1:18 %�������ɂ��ďd�ˍ��킹��
        Kg=bane(yosoi);
        KgBig=kakudai(Kg,yosoi);
        K=K+KgBig;
    end
    
    K0=K;
    F=zeros(dof*nNode,1);
    
    %�׏d�����̐ݒ�
    tempSetting(6+iLeg,1);
    
    %���E����(�x�[�X�����ׂčS��)
    boundary;
    
    %�ψʂ��v�Z����
    Krigid=M'*K*M;% �v���b�g�t�H�[�������̂ɂ���M
    Frigid=M'*F;
    deltaRigid=Krigid\Frigid;
    delta=M*deltaRigid;
        
    %�v���[�g���S�̕ψ�
    mat(:,iLeg)=plateCenter;
    mydelta(:,iLeg)=delta;
%     fprintf('*')
end

myDelta=mydelta;


% �O���t�̕`��ɂ���
flag=0;
for counter=1:size(varargin,2)
    flag=flag+strcmp(varargin{counter},'g');    %'g'�������flag�͔�[��
end

% ---------------------  �e�����ȉ~�̂̒����v�Z   ------------------------ %
[plAx,V]=JtoPlAx(mat,option);



end