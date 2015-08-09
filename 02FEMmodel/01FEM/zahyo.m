function Rout=zahyo(i,j)
%syntax: R=zahyo(i,j) 
% 
% ノードi->jの向きで、ｘ軸をとります。
% (ui yi zi ph th ps)GlobalにRをかけると、(ui yi zi ph th ps)Local
% r'=R*rの関係が成り立ちます。(r'は局所座標)
% Rは12×12の行列です
global node;
dx=node(1,j)-node(1,i);
dy=node(2,j)-node(2,i);
dz=node(3,j)-node(3,i);

r=[dx;dy;dz];

%角度を求めます。
%角度は、軸の軸方向回転に関する対象性に注意して、
%global座標をlocal座標に移す課程を次のように考えます。
%z軸周りにth回転->新しい座標系のy軸周りにph回転

%ま	ずz軸周りの回転角を求めます。
th=whatAngle(dx,dy);

%z軸周りでth回した場合に新しい座標系で見た、座標は、
Rz=...
[cos(th) sin(th) 0;...
 -sin(th) cos(th) 0;...
       0       0  1];%z軸周りの回転での座標変換行列が得られた。

r=Rz*r;
dx=r(1);
	%dy2=r2(2);%←必ず0になるので求めない
dz=r(3);

%次にy軸周りの回転角を求めます。
ph=whatAngle(dx,dz);

Ry=...
[cos(ph) 0 sin(ph);...
0 1 0;...
-sin(ph) 0 cos(ph)];%y軸周りの回転での座標変換行列が得られた。

%座標変換行列を求めます。
R1=Ry*Rz;%Globalで見たui,yi,ziをlocalで見たui,yi,ziに変換する行列

%一つのノードの持つ6個の変数をLocalからGlobalに変換する行列。
R2=zeros(6,6);
R2(1:3,1:3)=R1;
R2(4:6,4:6)=R1;

%二つのノードからなる12行ベクトルをGlobal座標に変換する行列
R=zeros(12,12);
R(1:6,1:6)=R2;
R(7:12,7:12)=R2;

Rout=R;
end


function th=whatAngle(dx,dy)
    if dx>0
    	th=atan(dy/dx);
    elseif dx==0
        if dy>0
        	th=pi/2;
        elseif dy<0
        	th=-pi/2;
        else
        	th=0;
    	end
    else
    	th=atan(dy/dx)+pi;
    end
end