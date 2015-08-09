function func_v=tawami(yosoi)
% ====
% tawami
%     syntax:tawamim(yoso_i)
%     yoso_i番の要素のたわみを計算します。
%     ローカル座標で軸と垂直方向の変位を、一方のノードから見ます。
% ====

global yoso

% 要素の長さを取得
L=yoso(3,yosoi);

% 要素を構成するノードのLocal変位を取得
dij=displacement(yosoi,'local');

% y,z方向変位を取得
yi=dij(2);
yj=dij(8);

zi=dij(3);
zj=dij(9);

% yz軸周りの回転量を取得
thi=dij(5);
psi=dij(6);
thj=dij(11);
psj=dij(12);
% ノードiの変位と角度を用いて、梁のたわみがない場合のノードjの変位を求めます
yj2=yi+L*psi;
zj2=zi-L*thi;

yi2=yj-L*psj;
zi2=zj+L*thj;
% 軸と垂直方向のたわみを求めます。
func_v=min(norm([yj-yj2,zj-zj2]),...
                    norm([yi-yi2,zi-zi2]));

end