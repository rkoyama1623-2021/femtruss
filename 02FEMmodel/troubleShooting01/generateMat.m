% ========================================================
% �t�@�C�����Fellipsoid1
% ���e�F
% ���x�s����󂯎��A����ȉ~�̂�`�悵�܂��B
% 
% 
% 
% 
% ========================================================

function [myMat,A]=generateMat(sr,thp,br,thb,pb,phi,theta,psi,param1,param2,param3)
myPath;


global node;	global yoso;
global dof;
global K;		global F;
global K0;	global F0;
global delta;
global mat;

%���x�}�g���b�N�X�𐶐�

%%%%%%%%%%%%% �m�[�h�̐ݒ� %%%%%%%%%%%%%%%%
%node�s��Ɨv�f�s��𐶐����܂��B

% param0=[sr,thp,br,thb,pb,phi,theta,psi]

%�m�[�h�̈ʒu�֌W

%�m�[�h�Ɨv�f�̐���
generateYosoAndNode(sr,thp,br,thb,pb,phi,theta,psi,param1,param2,param3);

mat=zeros(6,6);%���x�}�g���b�N�X�̉��n

printf('Creat matrix of system      ')

for i=1:6
    %�L���v�f�@�̏���
    maesyori;
    %�׏d�����̐ݒ�
    tempSetting(6+i,1);
    %���E����(�x�[�X�����ׂčS��)
    boundary;
    %�ψʂ��v�Z����
    solveDelta
    %�v���[�g���S�̕ψ�
    mat(:,i)=plateCenter();
    printf('*')
end
printf('\n\n')

%����ȉ~�̂𐶐�
J1=mat(1:3,:);
J2=mat(4:6,:);
myMat=mat;
% J2inv=pinv(J2')'%pinv�͏c���s��ɂ����K�p�ł��Ȃ����߁A�]�u�̋^���t�s������߂Ă���]�u���Ă���B
% A=J2inv'*J2inv
% [P,V]=drawEllipsoid(A)


J1inv=pinv(J1')';%pinv�͏c���s��ɂ����K�p�ł��Ȃ����߁A�]�u�̋^���t�s������߂Ă���]�u���Ă���B
A=J1inv'*J1inv;











end