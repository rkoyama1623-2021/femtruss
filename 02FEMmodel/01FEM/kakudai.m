function Kgbig=kakudai(Kg,a)
%a番要素のばね定数を拡大します。
% 拡大後の行列の大きさをlenMatで与えます。

    global yoso;
    global node;
	global dof;
    
	%要素aを構成するノードを求めます。
	i=yoso(1,a);
	j=yoso(2,a);
	n=dof*length(node(1,:));
	Kgbig=kakudai2(Kg,i,j,n);

end