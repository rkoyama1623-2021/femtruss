% ========================================================
% �t�@�C�����Fellipsoid1
% ���e�F
% ���x�s����󂯎��A����ȉ~�̂�`�悵�܂��B
% E��G�̒l�ɂ���ĉ���ȉ~�̂̎厲���ω����Ă��܂����R��T���܂��B
% 
% 
% 
% ========================================================
disp('======== start ==========')

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

for counter=1:10


paramSetting;

param1=[A1 I1 Ip1 E1 G1 alpha1 rho1 r1];
param2=[A2 I2 Ip2 E2 G2 alpha2 rho2 r2];
param3=[A3 I3 Ip3 E3*10^counter G3*10^counter alpha3 rho3 r3];

%�m�[�h�Ɨv�f�̐���
generateYosoAndNode(sr,thp,br,thb,pb,phi,theta,psi,param1,param2,param3);

mat=zeros(6,6);%���x�}�g���b�N�X�̉��n


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
    mat(:,i)=displacement(25);
    printf('*')
end
printf('\n\n')

	%����ȉ~�̂𐶐�
J1m(:,:,counter)=mat(1:3,:);
J2m(:,:,counter)=mat(4:6,:);

% J2inv=pinv(J2')'%pinv�͏c���s��ɂ����K�p�ł��Ȃ����߁A�]�u�̋^���t�s������߂Ă���]�u���Ă���B
% A=J2inv'*J2inv
% [P,V]=drawEllipsoid(A)

J1=J1m(:,:,counter);

J1inv=pinv(J1')';%pinv�͏c���s��ɂ����K�p�ł��Ȃ����߁A�]�u�̋^���t�s������߂Ă���]�u���Ă���B
A=J1inv'*J1inv;
[V(:,:,counter),D(:,:,counter),plAxes(:,:,counter)]=drawEllipsoid(A,[]);

end

for counter=1:10;
% (J1m(:,:,counter)-J1m(:,:,1))./J1m(:,:,1)
v1(:,counter)=V(:,1,counter);
end
cos_th=(1 0 0)*v1(:,:,1)



disp('======== end ==========')



