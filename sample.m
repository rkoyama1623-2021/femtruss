clearvars -global
clearvars

global node;	global yoso;
global K;		global F;
global K0;	global F0;
global delta;
global heatedYoso;

%%%%%%%%%%%%% �m�[�h�̐ݒ� %%%%%%%%%%%%%%%%
E1=68.6*10^9*2;
G1=25.7*10^9;
alpha1=24*10^-6;
rho1=2.7*10^3;%kg/m3

E2=68.6*10^9;
G2=25.7*10^9;
alpha2=24*10^-6;
rho2=2.7*10^3;%kg/m3

r1=0.015;
L1=0.160;
A1=pi*r1^2;
I1=pi/4*r1^4;
Ip1=pi/2*r1^4;

r2=0.015/2;
L2=0.160;
A2=pi*r2^2;
I2=pi/4*r2^4;
Ip2=pi/2*r2^4;

node(:,1)=[0 0 0]';
node(:,2)=[L1 0 0]';
node(:,3)=[L1 0 L2]';

yoso(:,1)=[1 2 L1 A1 I1 Ip1 E1 G1 alpha1 rho1 r1];
yoso(:,2)=[2 3 L2 A2 I2 Ip2 E2 G2 alpha2 rho2 r2];


% ======================== �׏d�ψʂ̌v�Z ============================
%�L���v�f�@�̏���
maesyori;
% �׏d�����̐ݒ�
fx=0;
fy=1;
fz=-1;
Mx=0;
My=0;
Mz=0;
dT=1;%�������鉷�x[K]

forceApply(2,fx,fy,fz,Mx,My,Mz);%�m�[�h2�Ԃ�
% tempSetting(1,dT);%�v�f1��dT[K]����-------------------------------------�M�ό`�̏ꍇ�͂�������R�����g�A�E�g����
                                                                        %�����āA�uforceApply�c�v�̑O�Ɂu%�v��u��
                                                                      

%���E����(�x�[�X�����ׂčS��)
kyokai(1,0,0,0,0,0,0);%�m�[�h1�̕��i�ψʂ����ׂ�0�ɍS��
kyokai(3,'n','n','n',0,0,0);%�m�[�h3�̉�]�ψʂ��[���ɍS�����A���i�͎��R

%�ψʂ��v�Z����
delta=K\F;

%�`��
graph3d(10^5)%�ψʂ�10^5�{�Ɋg��
view(3)
axis([-0.1,0.2,-0.1,0.1,-0.1,0.3])


