% ========================================================
% �t�@�C�����Fellipsoid2
% ���e�F
% ���x�s����󂯎��A����ȉ~�̂�`�悵�܂��B
% �������A�p�xOmega���O�ɍS�����܂��B
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
global heatedYoso;

%���x�}�g���b�N�X�𐶐�

%%%%%%%%%%%%% �m�[�h�̐ݒ� %%%%%%%%%%%%%%%%
%node�s��Ɨv�f�s��𐶐����܂��B

% param0=[sr,thp,br,thb,pb,phi,theta,psi]



%�m�[�h�̈ʒu�֌W

paramSetting;


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
    %�ψʂ��v�Z����
    solveDelta
    %�v���[�g���S�̕ψ�
    mat(:,i)=plateCenter;
    fprintf('*')
end
fprintf('\n\n')
disp(mat);

%����ȉ~�̂𐶐�(omega�S��)
J1=mat(1:3,:);
J2=mat(4:6,:);

omega=[0 0 0]';
qsize=1;
[r,Q]=qIs(J2,omega,qsize);


J2inv=pinv(J2')';
tempJ=J1*Q;


tempJinv=pinv(tempJ')';
A=tempJinv'*tempJinv;
r0=J1*J2inv*omega;
[V,D,plAx]=drawEllipsoid(A,r0)

% graph3d(3000)

disp('======== end ==========')
