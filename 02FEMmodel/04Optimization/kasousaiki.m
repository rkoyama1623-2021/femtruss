% ======================================================
% file:kasousaiki
% detail:
% �݌v�p�����[�^�[�̂����AmatParam���󂯎��A����ȉ~�̂̎厲�̒������A
% ��l�����ǂ̒��x�傫������]�����܂��B
% �]�����āA��l�����傫�Ȓl���Ƃ����݌v�p�����[�^�[��߂�l�Ƃ��ĕԂ��܂��B
% 
% input:matRatio,matParam,kijun(����ȉ~�̂̎厲����)
% output:goodRatio,goodParam
% =======================================================

function [goodRatio,goodParam]=kasousaiki(matRatio,matParam,kijun)
global node;	global yoso;
global dof;
global K;		global F;
global K0;	global F0;
global delta;
global mat;

% ����������
temp=zeros(size(matRatio));
temp2=zeros(1,length(matRatio(1,:)));
goodRatio2=[temp;temp2];
temp=zeros(size(matParam));
goodParam2=[temp;temp2];

% param1~3=[A I Ip E G alpha rho]
% param1:�e���q���W�̕����l
% param2:�c�����ނ̕����l
% param3�v���[�g���ȂǍ�������

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

phi=180;theta=0;psi=0;%------�I�C���[�p--------------deg�œ���



k=0;
for i=1:length(matParam(1,:))
fprintf('param %d is being assessed.	',i)

pz=matParam(1,i);
pb=[0,0,pz]';

br=matParam(2,i);
thb=matParam(3,i);
sr=matParam(4,i);
thp=matParam(5,i);
alpha=matParam(6,i);
r=matParam(7,i);

%�e���q���W
r1=r;
A1=pi*r1^2;
I1=pi/4*r1^4;
Ip1=pi/2*r1^4;

param1=[A1 I1 Ip1 E1 G1 alpha1 rho1 r1];
param2=[A2 I2 Ip2 E2 G2 alpha2 rho2 r2];
param3=[A3 I3 Ip3 E3 G3 alpha3 rho3 r3];

%�m�[�h�Ɨv�f�̐���
generateYosoAndNode2(sr,thp,br,thb,pb,alpha,phi,theta,psi,param1,param2,param3);
mat=zeros(6,6);%���x�}�g���b�N�X�̉��n

for legi=1:6
    %�L���v�f�@�̏���
    maesyori;
    %�׏d�����̐ݒ�
    tempSetting(6+legi,1);
    %���E����(�x�[�X�����ׂčS��)
    boundary;
    %�ψʂ��v�Z����
    solveDelta
    %�v���[�g���S�̕ψ�
    mat(:,legi)=plateCenter();
    fprintf('*')
end

J1=mat(1:3,:);
J2=mat(4:6,:);
% �p���S�����ł̉���ȉ~�̂̎厲���v�Z
omega=[0 0 0]';
qsize=1;
[r,Q]=qIs(J2,omega,qsize);

J2inv=pinv(J2')';
tempJ=J1*Q;

tempJinv=pinv(tempJ')';
A=tempJinv'*tempJinv;
% r0=J1*J2inv*omega;

pl=plAxes(A);

q=pl-[kijun kijun kijun];

if (q(1)>0)&(q(2)>0)&(q(3)>0)
% fprintf('	Good! q is\n')
% disp(q)
fprintf('	G\n')
k=k+1;
Q=q*q';

goodRatio2(1:7,k)=matRatio(:,i);
goodRatio2(8,k)=Q;

goodParam2(1:7,k)=matParam(:,i);
goodParam2(8,k)=Q;
else
fprintf('	-\n')
end

end

goodRatio=goodRatio2(:,1:k);
goodParam=goodParam2(:,1:k);

save('goodDesign.mat','goodRatio','goodParam')

end
% ====================  �ޗ��p�����[�^�[�ɂ���========================== %


% �ȉ��̐ݒ�Ōv�Z�����Ƃ���A���R�r�s��̔�Ώ̐��F
% 1.1311e-008 
% ����ȉ~�̂̔�Ίp�s�񐫂�
% 2.8892e-009 
% �厲�̒������A
% 1.0e-006 *
% [    8.4708    8.4708    1.6990 ]
% 
% �v���[�g�̊p�x�΂����
% 5.6633e-006 
% 
% �ł��邩��A�덷�̒~�ς͖��Ȃ��ƍl�����B
% 
% 
% 
% 
% 
% 
% %---  ��{�ݒ�@�@----
% sr=0.05;%�v���[�g�̒��S-�����N����
% thp=pi/10;%�v���[�g���@(�����N�̈ʒu)
% 
% br=0.1;%�x�[�X�̒��S�[�����N����
% thb=pi/10;%�x�[�X���@(�����N�̈ʒu)
% 
% pb=[0 0 0.2]';%�x�[�X���W�n�Ō����v���b�g�t�H�[�����S�̃x�N�g��
% phi=0;theta=0;psi=0;%------�I�C���[�p--------------deg�œ���
% 		
% [sb,bb]=stwertPlatform(sr,thp,br,thb,pb,phi,theta,psi);%stwertPlatform��`�悷�邽�߁B�Ȃ��Ă�FEM�̌v�Z�͉\�B
% 
% 
% 
% % param1~3=[A I Ip E G alpha rho]
% % param1:�e���q���W�̕����l
% % param2:�c�����ނ̕����l
% % param3�v���[�g���ȂǍ�������
% 
% %�c������
% r2=0.015/2;
% A2=pi*r2^2;
% I2=pi/4*r2^4;
% Ip2=pi/2*r2^4;
% E2=68.6*10^9;
% G2=25.7*10^9;
% alpha2=24*10^-6;
% rho2=2.7*10^3;%kg/m3
% 
% 
% %�e���q���W
% r1=r2/10;
% A1=pi*r1^2;
% I1=pi/4*r1^4;
% Ip1=pi/2*r1^4;
% E1=68.6*10^9;
% G1=25.7*10^9;
% alpha1=24*10^-6;
% rho1=2.7*10^3;%kg/m3
% 
% 
% %�v���[�g�Ȃǂ̍�������
% r3=r2*10;
% A3=pi*r3^2;
% I3=pi/4*r3^4;
% Ip3=pi/2*r3^4;
% E3=E2*100;
% G3=G2*100;
% alpha3=24*10^-6;
% rho3=2.7*10^3;%kg/m3
% 
% 
% 
% 
