function Kg=bane(i)
%要素番号を与えると、そのばね行列(global座標)を返します
global yoso;

Klocal=bane2(i);


%座標変換の行列を生成します。
R=zahyo(yoso(1,i),yoso(2,i));

%global座標でのばね定数行列

Kg=R'*Klocal*R;

% sprintf('K of Yoso(%d) was created!\n',i)


end
