%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%	�X�`���A�[�g�v���b�g�t�H�[���̐݌v�p�����[�^����
%	�X�`���A�[�g�̃v���b�g�t�H�[���̃����N�ʒu���x�[�X���W�n�ŕ\���܂�

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% �p�x��deg!


function [sb,bb,sp]=stwertPlatform(sr,thp,br,thb,pb,phi,theta,psi)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%�v���b�g�t�H�[����̐ڑ������N�̈ʒu(�v���b�g�t�H�[�����W�n)
%�e�����N�̈ʒu���x�N�g���Ŋi�[���܂��B

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thp=thp*pi/180;
thb=thb*pi/180;



sp=sr.*[cos(-thp) sin(-thp) 0;...
cos(thp) sin(thp) 0;...
cos(2*pi/3-thp) sin(2*pi/3-thp) 0;...
cos(2*pi/3+thp) sin(2*pi/3+thp) 0;...
cos(4*pi/3-thp) sin(4*pi/3-thp) 0;...
cos(4*pi/3+thp) sin(4*pi/3+thp) 0]';%�]�u
%���W�ϊ��s��
%�I�C���[�p�ŕ\���Ă��܂��B
%�x�[�X���W�n�̎���z->x->z�̏���(�����V�������W�n��)�񂷂ƃv���[�g�v���[�g���W�n�̎��ɂȂ�܂��B
%R=R3*R2*R1�ŁArp=R*rb(rp�̓v���[�g���W�n�ł̍��W�Arb�̓x�[�X���W�n�ł̍��W)
phi=phi*pi/180;theta=theta*pi/180;psi=psi*pi/180;%deg->rad�֕ϊ�
R1=[cos(phi) sin(phi) 0;-sin(phi) cos(phi) 0;0 0 1];
R2=[1 0 0;0 cos(theta) sin(theta);0 -sin(theta) cos(theta)];
R3=[cos(psi) sin(psi) 0;-sin(psi) cos(psi) 0;0 0 1];
R=R3*R2*R1;
%�v���b�g�t�H�[���̒��S����ڑ������N�܂ł̃x�N�g����base���W�n�֕ϊ����܂�
sb=R'*sp+pb*ones(1,6);%�x�[�X���W�n�Ō������M�̐ڑ������N�̈ʒu���x�N�g���ł܂Ƃ߂��s��


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%b�x�N�g���i�x�[�X�̐ڑ������N�j

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bb=br.*[...
cos(5*pi/3+thb) sin(5*pi/3+thb) 0;...
cos(pi/3-thb) sin(pi/3-thb) 0;...
cos(pi/3+thb) sin(pi/3+thb) 0;...
cos(pi-thb) sin(pi-thb) 0;...
cos(pi+thb) sin(pi+thb) 0;...
cos(5*pi/3-thb) sin(5*pi/3-thb) 0;...
]';

end
