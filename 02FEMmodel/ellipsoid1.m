% ========================================================
% �t�@�C�����Fellipsoid1
% ���e�F
% ���x�s����󂯎��A����ȉ~�̂�`�悵�܂��B
% �S���Ȃ��̉���ȉ~��
% 
% 
% 
% ========================================================
disp('======== start ==========')




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

paramSetting2;


param1=[A1 I1 Ip1 E1 G1 alpha1 rho1 r1];
param2=[A2 I2 Ip2 E2 G2 alpha2 rho2 r2];
param3=[A3 I3 Ip3 E3 G3 alpha3 rho3 r3];

%�m�[�h�Ɨv�f�̐���
generateYosoAndNode2(sr,thp,br,thb,pb,alphaLeg,phi,theta,psi,param1,param2,param3);

mat=zeros(6,6);%���x�}�g���b�N�X�̉��n

fprintf('Creat matrix of system      ')

for i=1:6
    %�L���v�f�@�̏���
    maesyori;
    %�׏d�����̐ݒ�
    tempSetting(6+i,1);
    %���E����(�x�[�X�����ׂčS��)
    boundary;
% 	boundaryPlate;
    %�ψʂ��v�Z����
    solveDelta
    %�v���[�g���S�̕ψ�
    mat(:,i)=plateCenter();
    fprintf('*')
end
fprintf('\n\n')
disp(mat);

matCheck(mat);

	%����ȉ~�̂𐶐�
		J1=mat(1:3,:);
		J2=mat(4:6,:);

% J2inv=pinv(J2')'%pinv�͏c���s��ɂ����K�p�ł��Ȃ����߁A�]�u�̋^���t�s������߂Ă���]�u���Ă���B
% A=J2inv'*J2inv
% [P,V]=drawEllipsoid(A)


J1inv=pinv(J1')';%pinv�͏c���s��ɂ����K�p�ł��Ȃ����߁A�]�u�̋^���t�s������߂Ă���]�u���Ă���B
A=J1inv'*J1inv
[V,D,plAx]=drawEllipsoid(A,[])



disp('======== end ==========')

