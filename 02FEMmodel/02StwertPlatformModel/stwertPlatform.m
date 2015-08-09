%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%	スチュアートプラットフォームの設計パラメータから
%	スチュアートのプラットフォームのリンク位置をベース座標系で表します

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 角度はdeg!


function [sb,bb,sp]=stwertPlatform(sr,thp,br,thb,pb,phi,theta,psi)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%プラットフォーム上の接続リンクの位置(プラットフォーム座標系)
%各リンクの位置を列ベクトルで格納します。

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thp=thp*pi/180;
thb=thb*pi/180;



sp=sr.*[cos(-thp) sin(-thp) 0;...
cos(thp) sin(thp) 0;...
cos(2*pi/3-thp) sin(2*pi/3-thp) 0;...
cos(2*pi/3+thp) sin(2*pi/3+thp) 0;...
cos(4*pi/3-thp) sin(4*pi/3-thp) 0;...
cos(4*pi/3+thp) sin(4*pi/3+thp) 0]';%転置
%座標変換行列
%オイラー角で表しています。
%ベース座標系の軸をz->x->zの順に(順次新しい座標系で)回すとプレートプレート座標系の軸になります。
%R=R3*R2*R1で、rp=R*rb(rpはプレート座標系での座標、rbはベース座標系での座標)
phi=phi*pi/180;theta=theta*pi/180;psi=psi*pi/180;%deg->radへ変換
R1=[cos(phi) sin(phi) 0;-sin(phi) cos(phi) 0;0 0 1];
R2=[1 0 0;0 cos(theta) sin(theta);0 -sin(theta) cos(theta)];
R3=[cos(psi) sin(psi) 0;-sin(psi) cos(psi) 0;0 0 1];
R=R3*R2*R1;
%プラットフォームの中心から接続リンクまでのベクトルをbase座標系へ変換します
sb=R'*sp+pb*ones(1,6);%ベース座標系で見たお皿の接続リンクの位置を列ベクトルでまとめた行列


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%bベクトル（ベースの接続リンク）

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bb=br.*[...
cos(5*pi/3+thb) sin(5*pi/3+thb) 0;...
cos(pi/3-thb) sin(pi/3-thb) 0;...
cos(pi/3+thb) sin(pi/3+thb) 0;...
cos(pi-thb) sin(pi-thb) 0;...
cos(pi+thb) sin(pi+thb) 0;...
cos(5*pi/3-thb) sin(5*pi/3-thb) 0;...
]';

end
