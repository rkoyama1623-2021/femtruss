% ======================================================================
% file name:femMain5
% detail:
% �v���b�g�t�H�[����FEM���f�����烄�R�r�s������߂܂�
% �v���[�g�͊��S���̂Ƃ��āA�v���[�g���S�̕ψʂɊ�Â��āA
% �e�o�̓����N�̕ψʂ�^���܂��B
% mat=femMain5()
% [delta_plateCenter,delta,Fr,Fall]=femMain5('t',[0,0,0,0,0,0])
% ======================================================================

function [varargout]=femMain5(varargin)
global node;	global yoso;
global dof;
global K;		global F;
global K0;      global F0;
global delta;   global deltaRigid;
global heatedYoso;

dof=6;	%��̐ړ_�������R�x�ł��B����͕��iuv�Ɗp�xth�̂R���R�x

% �����̉��
input=struct('t',[0,0,0,0,0,0],'mat',1,'iLegVect',[1:6]);
i=1;
while i<nargin
    switch varargin{i}
        case 't'
            input.mat=0;
            input.t=varargin{i+1};
            input.iLegVect=1:1;% �������ɉ��M�������ʂ����߂邱�Ƃ�\���܂�
            i=i+2;
        otherwise
            i=i+1;
    end
end


% ------------------  �m�[�h�Ɨv�f�̐���   -----------------------

% i��ڂ̐����́Ai�ԗv�f�����p�����[�^�ŁA�P�ڃm�[�h�ԍ��A�Q�ڃm�[�h�ԍ�
%                                   �AL�AE,G�AI�AIp,A�A���c���W��,���x�ł��B
% ��ԍ����m�[�h�̔ԍ��ł��B��x�N�g���̐����́A�m�[�h�����W�A�m�[�hy���W,�m�[�hz���W

paramSetting_final;

param1=[A1 I1 Ip1 E1 G1 alpha1 rho1 r1];
param2=[A2 I2 Ip2 E2 G2 alpha2 rho2 r2];
param3=[A3 I3 Ip3 E3 G3 alpha3 rho3 r3];


%�m�[�h�Ɨv�f�̐���
generateYosoAndNode2(sr,thp,br,thb,pb,alphaLeg,ph,th,ps,param1,param2,param3);


mat=zeros(6,6);%���x�}�g���b�N�X�̉��n

% fprintf('Creat matrix of system      ')

nNode=size(node,2);
nNodeVertual=nNode-5;
M=zeros(dof*nNode,dof*nNodeVertual);
matPlate=zeros(6,6,6);
for nodei=1:6
% �v���b�g�t�H�[�����S�Əo�̓����N�̊Ԃ̊֌W��^������W
    s=sb(:,nodei)-pb;
    s1=s(1);
    s2=s(2);
    s3=s(3);

    matPlate2=[0 s3 -s2;-s3 0 s1;s2 -s1 0];
    matPlate1=[eye(3) matPlate2;zeros(3) eye(3)];
    matPlate(:,:,nodei)=matPlate1;
    M(1+dof*(nodei-1):dof*nodei,1:6)=matPlate1;
end
M(1+dof*6:dof*nNode,1+dof:dof*nNodeVertual)=eye(dof*(nNodeVertual-1));

for iLeg=input.iLegVect
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
    %���M�v�f�Ɖ��M���x���L������s��
    heatedYoso=zeros(2,1);
    if input.mat
        tempSetting(6+iLeg,1);
    else
        for i=1:6
            tempSetting(6+i,input.t(i))
        end
    end
    %���E����(�x�[�X�����ׂčS��)
    K0=K;
    F0=F;
    boundary;
%     kyokai(2,'n','n','n',0,0,0)
%     kyokai(2,0,0,0,0,0,0)
    
    %�ψʂ��v�Z����(M'�̗��p)
    Krigid=M'*K*M;% �v���b�g�t�H�[�������̂ɂ���M
    Frigid=M'*F;
%     deltaRigid=Krigid\Frigid;
%     delta=M*deltaRigid;
    
    %pinv�̗��p
    deltaRigid=pinv(K*M)*F;
    delta=M*deltaRigid;
    %�v���[�g���S�̕ψ�
    mat(:,iLeg)=plateCenter;
%     fprintf('*')
    
%     ���͓��̌v�Z
    Fall=K0*delta;
    Fr=Fall-F0;
    F=Fall;


end

% �߂�l�̌���
if input.mat
    varargout{1}=mat;
else
    varargout{1}=plateCenter;
    varargout{2}=delta;
    varargout{3}=Fr;
    varargout{4}=Fall;
end

% plAx=JtoPlAx(mat,'p2')


end