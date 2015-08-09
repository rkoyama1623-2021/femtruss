function generateYosoAndNode(sr,thp,br,thb,pb,phi,theta,psi,param1,param2,param3)
%�L���v�f�@�ŗp����m�[�h�Ɨv�f�𐶐�
%�݌v�p�����[�^�̐ݒ�͈����Ŏ󂯎��܂��B
% yoso�̗�x�N�g����
% node_i node_j L A I Ip E G alpha rho r


% param1~3=[A I Ip E G alpha rho r]
% param1:�e���q���W�̕����l
% param2:�c�����ނ̕����l
% param3�v���[�g���ȂǍ�������


global node;
global yoso;

%-------  ���̐ݒ�@-------------------%
%�X�`���A�[�g�̃v���b�g�t�H�[���̃����N�z�u
[sb,bb]=stwertPlatform(sr,thp,br,thb,pb,phi,theta,psi);
%graph3dPlatform(pb,sb,bb);


%���x�N�g��Li����Ȃ�s�񐶐�
L=sb-bb;
%���x�N�g���̒P�ʃx�N�g������
Llength=ones(3,1)*sqrt(sum(L.*L));
Le=L./Llength;

%�x�[�X���̒e���q���W-�c�����ފԃ����N�ʒu�̃x�N�g���𐶐�
lsbr=Llength/10;
lbb=bb+lsbr.*Le;%��������

%�v���[�g���q���W�̈ʒu�x�N�g���񐶐�
lsb=sb-lsbr.*Le;

%node�s�񐶐�(�擪�͂��M�̒��S)
node=[sb lsb lbb bb];

%yoso�s�񐶐�
%�����\������v�f�𐶐�
yoso1(1,:)=[1:18];%�e�v�f�̂������m�[�h
yoso1(2,:)=[7:24];%�p�v�f�̂������m�[�h

L=0;
%�e���q���W�E�c�����ށE�e���q���W
yoso1(3:3+length(param1),1:6)=[L param1]'*ones(1,6);
yoso1(3:3+length(param2),7:12)=[L param2]'*ones(1,6);
yoso1(3:3+length(param1),13:18)=[L param1]'*ones(1,6);


%���M�ƃx�[�X�Ƃ��M�̒��S�𐶐����ĕt��������(�Ō�̗v�f�̓m�[�h1�ƃv���[�g���S���Ȃ��v�f)
yoso2(1,:)=[1:6 19:24];
yoso2(2,:)=[2:6 1 20:24 19];
yoso2(3:3+length(param3),:)=[L param3]'*ones(1,length(yoso2(1,:)));

yoso=[yoso1 yoso2];

CheckLength('node');%�v�f�̐����̒����ŁA�v�f�̒������m�[�h�̈ʒu�֌W�Ɩ������Ȃ����`�F�b�N�B����������Ƃ��́A�m�[�h�ɍ��킹�āA����������ς��܂��B

end