%---  基本設定　　----
sr=0.075;%プレートの中心-リンク距離
thp=10;%プレート寸法(リンクの位置)

br=0.15;%ベースの中心ーリンク距離
thb=10;%ベース寸法(リンクの位置)

pb=[0 0 0.2]';%ベース座標系で見たプラットフォーム中心のベクトル
ph=0;th=0;ps=0;%------オイラー角--------------degで入力

[sb,bb,sp]=stwertPlatform(sr,thp,br,thb,pb,ph,th,ps);



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
r1=0.001;
A1=pi*r1^2;
I1=pi/4*r1^4;
Ip1=pi/2*r1^4;
E1=68.6*10^9;
G1=25.7*10^9;
alpha1=24*10^-6;
rho1=2.7*10^3;%kg/m3


%プレートなどの剛性部材
r3=r2*10;
A3=pi*r3^2;
I3=pi/4*r3^4;
Ip3=pi/2*r3^4;
E3=E2*100;
G3=G2*100;
alpha3=24*10^-6;
rho3=2.7*10^3;%kg/m3

alphaLeg=1/10;
