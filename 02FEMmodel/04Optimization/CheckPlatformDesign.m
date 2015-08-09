
% ======================== パラメーターの設定 ==========================

global node;	global yoso;
global dof;
global K;		global F;
global K0;	global F0;
global delta;
global mat;

% vector=[pMax,brMax,thpMax,sr,thpMax,alphaMax,rMax]

% vector=[0.21,0.42,0.01,0.001,0.01,0.05,0.0001]';
[br,parami]=min(goodParam(2,:))
vector=goodParam(:,parami)%ここに設計パラメーターのベクトルを与えます。

[sr,thp,br,thb,pb,r1,alpha]=loadParam(vector)

%膨張部材
r2=0.015/2;
A2=pi*r2^2;
I2=pi/4*r2^4;
Ip2=pi/2*r2^4;
E2=68.6*10^9;
G2=25.7*10^9;
alpha2=24*10^-6;
rho2=2.7*10^3;%kg/m3


%弾性ヒンジ
E1=68.6*10^9;
G1=25.7*10^9;
alpha1=24*10^-6;
rho1=2.7*10^3;%kg/m3


%プレートなどの剛性部材
r3=r2*2;
A3=pi*r3^2;
I3=pi/4*r3^4;
Ip3=pi/2*r3^4;
E3=E2*100;
G3=G2*100;
alpha3=24*10^-6;
rho3=2.7*10^3;%kg/m3

phi=0;theta=0;psi=180;%------オイラー角--------------degで入力


%弾性ヒンジ
% r1はすでに定義済み
A1=pi*r1^2;
I1=pi/4*r1^4;
Ip1=pi/2*r1^4;

param1=[A1 I1 Ip1 E1 G1 alpha1 rho1 r1];
param2=[A2 I2 Ip2 E2 G2 alpha2 rho2 r2];
param3=[A3 I3 Ip3 E3 G3 alpha3 rho3 r3];

%ノードと要素の生成
generateYosoAndNode2(sr,thp,br,thb,pb,alpha,phi,theta,psi,param1,param2,param3);

% ==================== モデルの描画 ========================
graph3dWithoutDisplacement()

% % ======================== 荷重変位の計算 ============================
% %有限要素法の準備
% maesyori;
% % 荷重条件の設定
% tempSetting(7,1);
% %境界条件(ベースをすべて拘束)
% boundary;
% %変位を計算する
% solveDelta
% %プレート中心の変位
% plateCenter()
% %描画
% graph3d(3*10^2)%変位拡大倍率を与えます。
% view(90,90)

% % ===================== 可操作楕円体の描画 ================================
% %ノードと要素の生成
% generateYosoAndNode2(sr,thp,br,thb,pb,alpha,phi,theta,psi,param1,param2,param3);
% mat=zeros(6,6);%感度マトリックスの下地
% 
% for legi=1:6
%     %有限要素法の準備
%     maesyori;
% 	%荷重条件の設定
%     tempSetting(6+legi,1);
%     %境界条件(ベースをすべて拘束)
%     boundary;
%     %変位を計算する
%     solveDelta
%     %プレート中心の変位
%     mat(:,legi)=plateCenter();
%     fprintf('*')
% end
% 
% J1=mat(1:3,:);
% J2=mat(4:6,:);
% % 姿勢拘束下での可操作楕円体の主軸を計算
% omega=[0 0 0]';
% qsize=1;
% [r,Q]=qIs(J2,omega,qsize);
% 
% J2inv=pinv(J2')';
% tempJ=J1*Q;
% 
% 
% tempJinv=pinv(tempJ')';
% A=tempJinv'*tempJinv;
% 
% drawEllipsoid(A,[])












