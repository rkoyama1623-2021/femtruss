function CheckLength(str)
%ノードの座標と要素の長さパラメータの値に不整合がないか確認する。不整合があった場合には、strに従って操作。
%strが'node'ならnode優先で要素のLを書き換える。'yoso'ならエラーを出して、ノードを編集しなおす。

global yoso;global node;

for i=1:length(yoso(1,:))%要素を１から順にチェック

	L=yoso(3,i);
	
	nodei=yoso(1,i);
	nodej=yoso(2,i);
	
	xi=node(1,nodei);
	yi=node(2,nodei);
	zi=node(3,nodei);
	xj=node(1,nodej);
	yj=node(2,nodej);
	zj=node(3,nodej);

	kyori=sqrt((xi-xj)^2+(yi-yj)^2+(zi-zj)^2);
	
 if abs(kyori-L)>0.001*L
	    if str=='node'
			yoso(3,i)=kyori;
%			sprintf('the value of L in yoso %d was corrected!\n',i)
     	else
			yoso=0;
%			disp('Error!!! L in yoso differs from the distance between nodes')
    	end
 	end

end