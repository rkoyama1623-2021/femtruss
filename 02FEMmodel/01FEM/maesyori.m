function maesyori()


global node;	global yoso;
global dof;
global K;		global F;
global K0;
global heatedYoso
dof=6;	%一つの接点が持つ自由度です。今回は並進uvと角度thの３自由度


%yoso=zeros(8,nYoso);	%要素の集合。i列目の成分は、i番要素がもつパラメータで、１つ目のノードの番号、２つ目のノード番号、L、E,G、I、Ip,A、線膨張係数,密度です。
%node=zeros(3,nNode);%ノードの位置。列番号がノードの番号です。列ベクトルの成分は、ノードｘ座標、ノードy座標,ノードz座標



%---------------------------
%
%要素の設定があったところ
%
%---------------------------

%加熱要素と加熱温度を記憶する行列
heatedYoso=zeros(2,1);


% printf('Node is\n')
% disp(node)
nNode=length(node(1,:));
% printf('yoso is\n')
% disp(yoso)
nYoso=length(yoso(1,:));



%%%%%%%%%%%%% ばね定数行列を作成 %%%%%%%%%%
%要素1から順にばね定数(global)を求め、拡大し、重ね合わせます。

K=zeros(dof*nNode,dof*nNode);
for i=1:nYoso
	Kg=bane(i);
	KgBig=kakudai(Kg,i);
	K=K+KgBig;
end
K0=K;%境界条件に合わせてKを変形する前の状態を保存
%printf('K is\n')
%disp(K)

%%%%%%%%%%%% 荷重条件の前処理 %%%%%%%%%%%%%%%%
F=zeros(dof*nNode,1);

%---------------------------------------------------------------------------------------

end
