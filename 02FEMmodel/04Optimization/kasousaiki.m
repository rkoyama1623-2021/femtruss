% ======================================================
% file:kasousaiki
% detail:
% 設計パラメーターのうち、matParamを受け取り、可操作楕円体の主軸の長さが、
% 基準値よりもどの程度大きいかを評価します。
% 評価して、基準値よりも大きな値をとった設計パラメーターを戻り値として返します。
% 
% input:matRatio,matParam,kijun(可操作楕円体の主軸長さ)
% output:goodRatio,goodParam
% =======================================================

function [goodRatio,goodParam]=kasousaiki(matRatio,matParam,kijun)
global node;	global yoso;
global dof;
global K;		global F;
global K0;	global F0;
global delta;
global mat;

% メモリ準備
temp=zeros(size(matRatio));
temp2=zeros(1,length(matRatio(1,:)));
goodRatio2=[temp;temp2];
temp=zeros(size(matParam));
goodParam2=[temp;temp2];

% param1~3=[A I Ip E G alpha rho]
% param1:弾性ヒンジの物性値
% param2:膨張部材の物性値
% param3プレートや台など剛性部材

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

phi=180;theta=0;psi=0;%------オイラー角--------------degで入力



k=0;
for i=1:length(matParam(1,:))
fprintf('param %d is being assessed.	',i)

pz=matParam(1,i);
pb=[0,0,pz]';

br=matParam(2,i);
thb=matParam(3,i);
sr=matParam(4,i);
thp=matParam(5,i);
alpha=matParam(6,i);
r=matParam(7,i);

%弾性ヒンジ
r1=r;
A1=pi*r1^2;
I1=pi/4*r1^4;
Ip1=pi/2*r1^4;

param1=[A1 I1 Ip1 E1 G1 alpha1 rho1 r1];
param2=[A2 I2 Ip2 E2 G2 alpha2 rho2 r2];
param3=[A3 I3 Ip3 E3 G3 alpha3 rho3 r3];

%ノードと要素の生成
generateYosoAndNode2(sr,thp,br,thb,pb,alpha,phi,theta,psi,param1,param2,param3);
mat=zeros(6,6);%感度マトリックスの下地

for legi=1:6
    %有限要素法の準備
    maesyori;
    %荷重条件の設定
    tempSetting(6+legi,1);
    %境界条件(ベースをすべて拘束)
    boundary;
    %変位を計算する
    solveDelta
    %プレート中心の変位
    mat(:,legi)=plateCenter();
    fprintf('*')
end

J1=mat(1:3,:);
J2=mat(4:6,:);
% 姿勢拘束下での可操作楕円体の主軸を計算
omega=[0 0 0]';
qsize=1;
[r,Q]=qIs(J2,omega,qsize);

J2inv=pinv(J2')';
tempJ=J1*Q;

tempJinv=pinv(tempJ')';
A=tempJinv'*tempJinv;
% r0=J1*J2inv*omega;

pl=plAxes(A);

q=pl-[kijun kijun kijun];

if (q(1)>0)&(q(2)>0)&(q(3)>0)
% fprintf('	Good! q is\n')
% disp(q)
fprintf('	G\n')
k=k+1;
Q=q*q';

goodRatio2(1:7,k)=matRatio(:,i);
goodRatio2(8,k)=Q;

goodParam2(1:7,k)=matParam(:,i);
goodParam2(8,k)=Q;
else
fprintf('	-\n')
end

end

goodRatio=goodRatio2(:,1:k);
goodParam=goodParam2(:,1:k);

save('goodDesign.mat','goodRatio','goodParam')

end
% ====================  材料パラメーターについて========================== %


% 以下の設定で計算したところ、ヤコビ行列の非対称性：
% 1.1311e-008 
% 可操作楕円体の非対角行列性が
% 2.8892e-009 
% 主軸の長さが、
% 1.0e-006 *
% [    8.4708    8.4708    1.6990 ]
% 
% プレートの角度ばらつきが
% 5.6633e-006 
% 
% であるから、誤差の蓄積は問題ないと考えた。
% 
% 
% 
% 
% 
% 
% %---  基本設定　　----
% sr=0.05;%プレートの中心-リンク距離
% thp=pi/10;%プレート寸法(リンクの位置)
% 
% br=0.1;%ベースの中心ーリンク距離
% thb=pi/10;%ベース寸法(リンクの位置)
% 
% pb=[0 0 0.2]';%ベース座標系で見たプラットフォーム中心のベクトル
% phi=0;theta=0;psi=0;%------オイラー角--------------degで入力
% 		
% [sb,bb]=stwertPlatform(sr,thp,br,thb,pb,phi,theta,psi);%stwertPlatformを描画するため。なくてもFEMの計算は可能。
% 
% 
% 
% % param1~3=[A I Ip E G alpha rho]
% % param1:弾性ヒンジの物性値
% % param2:膨張部材の物性値
% % param3プレートや台など剛性部材
% 
% %膨張部材
% r2=0.015/2;
% A2=pi*r2^2;
% I2=pi/4*r2^4;
% Ip2=pi/2*r2^4;
% E2=68.6*10^9;
% G2=25.7*10^9;
% alpha2=24*10^-6;
% rho2=2.7*10^3;%kg/m3
% 
% 
% %弾性ヒンジ
% r1=r2/10;
% A1=pi*r1^2;
% I1=pi/4*r1^4;
% Ip1=pi/2*r1^4;
% E1=68.6*10^9;
% G1=25.7*10^9;
% alpha1=24*10^-6;
% rho1=2.7*10^3;%kg/m3
% 
% 
% %プレートなどの剛性部材
% r3=r2*10;
% A3=pi*r3^2;
% I3=pi/4*r3^4;
% Ip3=pi/2*r3^4;
% E3=E2*100;
% G3=G2*100;
% alpha3=24*10^-6;
% rho3=2.7*10^3;%kg/m3
% 
% 
% 
% 
