% ========================================================
% ファイル名：whetherDiagOrNot
% 内容：
% 感度行列を受け取り、可操作楕円体を与える行列を取得します。
% 
% 行列が対角行列と言えるか検証します。
% 1行目：対角行列か、2行目：プレート変形の大きさ、3行目：固有値の値の比
% いずれも相対誤差
% ========================================================


disp('======== start ==========')

global node;	global yoso;
global dof;
global K;		global F;
global K0;	global F0;
global delta;
global mat;

%感度マトリックスを生成

%%%%%%%%%%%%% ノードの設定 %%%%%%%%%%%%%%%%
%node行列と要素行列を生成します。

% param0=[sr,thp,br,thb,pb,phi,theta,psi]


%ノードの位置関係

paramSetting;


eps=zeros(5,10);%1行目：対角行列か、2行目：プレート変形の大きさ、3行目：固有値の値の比

myMat=zeros(6,6,10);

for counter=1:10

r3=r2;
A3=pi*r3^2;
I3=pi/4*r3^4;
Ip3=pi/2*r3^4;



param1=[A1 I1 Ip1 E1 G1 alpha1 rho1 r1];
param2=[A2 I2 Ip2 E2 G2 alpha2 rho2 r2];
param3=[A3 I3 Ip3 E3*10^counter G3*10^counter alpha3 rho3 r3];

%--------------- ヤコビ行列と楕円体を与える行列の生成 -------------------------%
[mat,A]=generateMat(sr,thp,br,thb,pb,phi,theta,psi,param1,param2,param3);

myMat(:,:,counter)=mat;

% 対角行列か検証
[x,x2]=isDiag(A)
eps(1,counter)=x2;


% 同一平面上にあるか検証
eps(2,counter)=onPlain;

% 固有値が等しい値か検証
[V,D]=eig(A);
lambda=diag(D);
eps(3,counter)=abs(lambda(1)-lambda(2))/lambda(2);

% matの対象性(5行目)
eps(5,counter)=matCheck(mat);

end

%ヤコビ行列がどの程度変化しているか検証
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









