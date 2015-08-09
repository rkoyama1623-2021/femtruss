function tempSetting(i,temp)
% tempSetting(yoso_i,temperature)
%要素番号iをtemp[℃]温めます。
%B'[EI 0;0 AE]を求めます(maxima で求めておく。)
global yoso
global heatedYoso

%heatedYosoに温める要素を登録
if heatedYoso(1)==0%初めての登録
    heatedYoso=[i,temp]';
else%2回目以降
    colN=size(heatedYoso(2));
    newHeatedYoso=[i,temp]';
    heatedYoso=[heatedYoso newHeatedYoso];
end


nodei=yoso(1,i);
nodej=yoso(2,i);

L=yoso(3,i);
A=yoso(4,i);
E=yoso(7,i);
alpha=yoso(9,i);



fL=alpha*temp.*[-A*E,0,0,0,0,0,A*E,0,0,0,0,0]';%局所座標における接点荷重(maximaで計算した式に代入している)
R=zahyo(nodei,nodej);
fG=R'*fL;%局所座標における接点荷重をglobal座標に変換

forceApply(nodei,fG(1),fG(2),fG(3),fG(4),fG(5),fG(6));
forceApply(nodej,fG(7),fG(8),fG(9),fG(10),fG(11),fG(12));

end