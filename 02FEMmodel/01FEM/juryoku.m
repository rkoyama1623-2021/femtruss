function juryoku(i)

global yoso; global node;
global F;

%要素iに重力を加える。

%生成するfgの枠を作っておきます。
fgmoto=zeros(6*length(node(1,:)),1);

%重力加速度
g=1;

%要素ごとに重力の荷重ベクトルを作成し、全体へ拡大します。

nodei=yoso(1,i);%要素を構成するノード番号
nodej=yoso(2,i);
L=yoso(3,i);%要素iの長さL
A=yoso(4,i);%要素iの面積を取得
rho=yoso(10,i);%要素iの密度を取得

%N3の積分したものをmaximaであらかじめ求めておいた。
N3t=...
[L/2,0,0;... 
0,L/2,0;... 
0,0,L/2;... 
0,0,0;... 
0,0,-L^2/12;... 
0,L^2/12,0;... 
L/2,0,0;... 
0,L/2,0;... 
0,0,L/2;... 
0,0,0;... 
0,0,L^2/12;... 
0,-L^2/12,0] ;

%座標変換行列を求めます。
R=zahyo(nodei,nodej);%12変数をglobal座標->Local座標へ変換
R2=R(1:3,1:3);%力の３変数のみの変換
fgtemp=R'*N3t*R2*(rho*g*A.*[0;0;-1]);

%系全体に合わせて拡大します。
fgi=fgtemp(1:6);
fgj=fgtemp(7:12);

fg=zeros(6*length(node(1,:)),1);
fg(1+6*(nodei-1):6*nodei)=fgi;
fg(1+6*(nodej-1):6*nodej)=fgj;

fgmoto=fg+fgmoto;

F=F+fg;

end