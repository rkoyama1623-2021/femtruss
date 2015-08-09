% ========================================================
% ファイル名：ellipsoid1
% 内容：
% 感度行列を受け取り、可操作楕円体を描画します。
% EとGの値によって可操作楕円体の主軸が変化してしまう理由を探します。
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

%感度マトリックスを生成

%%%%%%%%%%%%% ノードの設定 %%%%%%%%%%%%%%%%
%node行列と要素行列を生成します。

% param0=[sr,thp,br,thb,pb,phi,theta,psi]



%ノードの位置関係

for counter=1:10


paramSetting;

param1=[A1 I1 Ip1 E1 G1 alpha1 rho1 r1];
param2=[A2 I2 Ip2 E2 G2 alpha2 rho2 r2];
param3=[A3 I3 Ip3 E3*10^counter G3*10^counter alpha3 rho3 r3];

%ノードと要素の生成
generateYosoAndNode(sr,thp,br,thb,pb,phi,theta,psi,param1,param2,param3);

mat=zeros(6,6);%感度マトリックスの下地


for i=1:6
    %有限要素法の準備
    maesyori;
    %荷重条件の設定
    tempSetting(6+i,1);
    %境界条件(ベースをすべて拘束)
    boundary;
    %変位を計算する
    solveDelta
    %プレート中心の変位
    mat(:,i)=displacement(25);
    printf('*')
end
printf('\n\n')

	%可操作楕円体を生成
J1m(:,:,counter)=mat(1:3,:);
J2m(:,:,counter)=mat(4:6,:);

% J2inv=pinv(J2')'%pinvは縦長行列にしか適用できないため、転置の疑似逆行列を求めてから転置している。
% A=J2inv'*J2inv
% [P,V]=drawEllipsoid(A)

J1=J1m(:,:,counter);

J1inv=pinv(J1')';%pinvは縦長行列にしか適用できないため、転置の疑似逆行列を求めてから転置している。
A=J1inv'*J1inv;
[V(:,:,counter),D(:,:,counter),plAxes(:,:,counter)]=drawEllipsoid(A,[]);

end

for counter=1:10;
% (J1m(:,:,counter)-J1m(:,:,1))./J1m(:,:,1)
v1(:,counter)=V(:,1,counter);
end
cos_th=(1 0 0)*v1(:,:,1)



disp('======== end ==========')



