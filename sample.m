clearvars -global
clearvars

global node;	global yoso;
global K;		global F;
global K0;	global F0;
global delta;
global heatedYoso;

%%%%%%%%%%%%% ノードの設定 %%%%%%%%%%%%%%%%
E1=68.6*10^9*2;
G1=25.7*10^9;
alpha1=24*10^-6;
rho1=2.7*10^3;%kg/m3

E2=68.6*10^9;
G2=25.7*10^9;
alpha2=24*10^-6;
rho2=2.7*10^3;%kg/m3

r1=0.015;
L1=0.160;
A1=pi*r1^2;
I1=pi/4*r1^4;
Ip1=pi/2*r1^4;

r2=0.015/2;
L2=0.160;
A2=pi*r2^2;
I2=pi/4*r2^4;
Ip2=pi/2*r2^4;

node(:,1)=[0 0 0]';
node(:,2)=[L1 0 0]';
node(:,3)=[L1 0 L2]';

yoso(:,1)=[1 2 L1 A1 I1 Ip1 E1 G1 alpha1 rho1 r1];
yoso(:,2)=[2 3 L2 A2 I2 Ip2 E2 G2 alpha2 rho2 r2];


% ======================== 荷重変位の計算 ============================
%有限要素法の準備
maesyori;
% 荷重条件の設定
fx=0;
fy=1;
fz=-1;
Mx=0;
My=0;
Mz=0;
dT=1;%加温する温度[K]

forceApply(2,fx,fy,fz,Mx,My,Mz);%ノード2番に
% tempSetting(1,dT);%要素1をdT[K]加温-------------------------------------熱変形の場合はこちらをコメントアウトする
                                                                        %そして、「forceApply…」の前に「%」を置く
                                                                      

%境界条件(ベースをすべて拘束)
kyokai(1,0,0,0,0,0,0);%ノード1の並進変位をすべて0に拘束
kyokai(3,'n','n','n',0,0,0);%ノード3の回転変位をゼロに拘束し、並進は自由

%変位を計算する
delta=K\F;

%描画
graph3d(10^5)%変位を10^5倍に拡大
view(3)
axis([-0.1,0.2,-0.1,0.1,-0.1,0.3])


