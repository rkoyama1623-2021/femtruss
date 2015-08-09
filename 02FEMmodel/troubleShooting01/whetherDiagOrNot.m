% ========================================================
% �t�@�C�����FwhetherDiagOrNot
% ���e�F
% ���x�s����󂯎��A����ȉ~�̂�^����s����擾���܂��B
% 
% �s�񂪑Ίp�s��ƌ����邩���؂��܂��B
% 1�s�ځF�Ίp�s�񂩁A2�s�ځF�v���[�g�ό`�̑傫���A3�s�ځF�ŗL�l�̒l�̔�
% ����������Ό덷
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

paramSetting;


eps=zeros(5,10);%1�s�ځF�Ίp�s�񂩁A2�s�ځF�v���[�g�ό`�̑傫���A3�s�ځF�ŗL�l�̒l�̔�

myMat=zeros(6,6,10);

for counter=1:10

r3=r2;
A3=pi*r3^2;
I3=pi/4*r3^4;
Ip3=pi/2*r3^4;



param1=[A1 I1 Ip1 E1 G1 alpha1 rho1 r1];
param2=[A2 I2 Ip2 E2 G2 alpha2 rho2 r2];
param3=[A3 I3 Ip3 E3*10^counter G3*10^counter alpha3 rho3 r3];

%--------------- ���R�r�s��Ƒȉ~�̂�^����s��̐��� -------------------------%
[mat,A]=generateMat(sr,thp,br,thb,pb,phi,theta,psi,param1,param2,param3);

myMat(:,:,counter)=mat;

% �Ίp�s�񂩌���
[x,x2]=isDiag(A)
eps(1,counter)=x2;


% ���ꕽ�ʏ�ɂ��邩����
eps(2,counter)=onPlain;

% �ŗL�l���������l������
[V,D]=eig(A);
lambda=diag(D);
eps(3,counter)=abs(lambda(1)-lambda(2))/lambda(2);

% mat�̑Ώې�(5�s��)
eps(5,counter)=matCheck(mat);

end

%���R�r�s�񂪂ǂ̒��x�ω����Ă��邩����
for counter=1:10
    eps(4,counter)=max(max(abs(	(myMat(:,:,counter)-myMat(:,:,1)	)./(myMat(:,:,1))	)));
end


func=eps;
plot(...
1:10,...
log10(eps(1,:)),...
1:10,...
log10(eps(2,:)),...
1:10,...
log10(eps(3,:)),...
1:10,...
log10(eps(4,:)),...
)
legend('diag?','plain?','eigenvalue?','jacobi?')
csvwrite('eps.csv',eps)
disp('======== end ==========')









