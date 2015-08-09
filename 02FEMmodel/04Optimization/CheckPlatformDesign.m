
% ======================== �p�����[�^�[�̐ݒ� ==========================

global node;	global yoso;
global dof;
global K;		global F;
global K0;	global F0;
global delta;
global mat;

% vector=[pMax,brMax,thpMax,sr,thpMax,alphaMax,rMax]

% vector=[0.21,0.42,0.01,0.001,0.01,0.05,0.0001]';
[br,parami]=min(goodParam(2,:))
vector=goodParam(:,parami)%�����ɐ݌v�p�����[�^�[�̃x�N�g����^���܂��B

[sr,thp,br,thb,pb,r1,alpha]=loadParam(vector)

%�c������
r2=0.015/2;
A2=pi*r2^2;
I2=pi/4*r2^4;
Ip2=pi/2*r2^4;
E2=68.6*10^9;
G2=25.7*10^9;
alpha2=24*10^-6;
rho2=2.7*10^3;%kg/m3


%�e���q���W
E1=68.6*10^9;
G1=25.7*10^9;
alpha1=24*10^-6;
rho1=2.7*10^3;%kg/m3


%�v���[�g�Ȃǂ̍�������
r3=r2*2;
A3=pi*r3^2;
I3=pi/4*r3^4;
Ip3=pi/2*r3^4;
E3=E2*100;
G3=G2*100;
alpha3=24*10^-6;
rho3=2.7*10^3;%kg/m3

phi=0;theta=0;psi=180;%------�I�C���[�p--------------deg�œ���


%�e���q���W
% r1�͂��łɒ�`�ς�
A1=pi*r1^2;
I1=pi/4*r1^4;
Ip1=pi/2*r1^4;

param1=[A1 I1 Ip1 E1 G1 alpha1 rho1 r1];
param2=[A2 I2 Ip2 E2 G2 alpha2 rho2 r2];
param3=[A3 I3 Ip3 E3 G3 alpha3 rho3 r3];

%�m�[�h�Ɨv�f�̐���
generateYosoAndNode2(sr,thp,br,thb,pb,alpha,phi,theta,psi,param1,param2,param3);

% ==================== ���f���̕`�� ========================
graph3dWithoutDisplacement()

% % ======================== �׏d�ψʂ̌v�Z ============================
% %�L���v�f�@�̏���
% maesyori;
% % �׏d�����̐ݒ�
% tempSetting(7,1);
% %���E����(�x�[�X�����ׂčS��)
% boundary;
% %�ψʂ��v�Z����
% solveDelta
% %�v���[�g���S�̕ψ�
% plateCenter()
% %�`��
% graph3d(3*10^2)%�ψʊg��{����^���܂��B
% view(90,90)

% % ===================== ����ȉ~�̂̕`�� ================================
% %�m�[�h�Ɨv�f�̐���
% generateYosoAndNode2(sr,thp,br,thb,pb,alpha,phi,theta,psi,param1,param2,param3);
% mat=zeros(6,6);%���x�}�g���b�N�X�̉��n
% 
% for legi=1:6
%     %�L���v�f�@�̏���
%     maesyori;
% 	%�׏d�����̐ݒ�
%     tempSetting(6+legi,1);
%     %���E����(�x�[�X�����ׂčS��)
%     boundary;
%     %�ψʂ��v�Z����
%     solveDelta
%     %�v���[�g���S�̕ψ�
%     mat(:,legi)=plateCenter();
%     fprintf('*')
% end
% 
% J1=mat(1:3,:);
% J2=mat(4:6,:);
% % �p���S�����ł̉���ȉ~�̂̎厲���v�Z
% omega=[0 0 0]';
% qsize=1;
% [r,Q]=qIs(J2,omega,qsize);
% 
% J2inv=pinv(J2')';
% tempJ=J1*Q;
% 
% 
% tempJinv=pinv(tempJ')';
% A=tempJinv'*tempJinv;
% 
% drawEllipsoid(A,[])












