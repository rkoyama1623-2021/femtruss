function generateYosoAndNode(sr,thp,br,thb,pb,phi,theta,psi,param1,param2,param3)
%有限要素法で用いるノードと要素を生成
%設計パラメータの設定は引数で受け取ります。
% yosoの列ベクトルは
% node_i node_j L A I Ip E G alpha rho r


% param1~3=[A I Ip E G alpha rho r]
% param1:弾性ヒンジの物性値
% param2:膨張部材の物性値
% param3プレートや台など剛性部材


global node;
global yoso;

%-------  足の設定　-------------------%
%スチュアートのプラットフォームのリンク配置
[sb,bb]=stwertPlatform(sr,thp,br,thb,pb,phi,theta,psi);
%graph3dPlatform(pb,sb,bb);


%足ベクトルLiからなる行列生成
L=sb-bb;
%足ベクトルの単位ベクトル生成
Llength=ones(3,1)*sqrt(sum(L.*L));
Le=L./Llength;

%ベース側の弾性ヒンジ-膨張部材間リンク位置のベクトルを生成
lsbr=Llength/10;
lbb=bb+lsbr.*Le;%生成完了

%プレート側ヒンジの位置ベクトル列生成
lsb=sb-lsbr.*Le;

%node行列生成(先頭はお皿の中心)
node=[sb lsb lbb bb];

%yoso行列生成
%足を構成する要素を生成
yoso1(1,:)=[1:18];%各要素のうち第一ノード
yoso1(2,:)=[7:24];%角要素のうち第二ノード

L=0;
%弾性ヒンジ・膨張部材・弾性ヒンジ
yoso1(3:3+length(param1),1:6)=[L param1]'*ones(1,6);
yoso1(3:3+length(param2),7:12)=[L param2]'*ones(1,6);
yoso1(3:3+length(param1),13:18)=[L param1]'*ones(1,6);


%お皿とベースとお皿の中心を生成して付け加える(最後の要素はノード1とプレート中心をつなぐ要素)
yoso2(1,:)=[1:6 19:24];
yoso2(2,:)=[2:6 1 20:24 19];
yoso2(3:3+length(param3),:)=[L param3]'*ones(1,length(yoso2(1,:)));

yoso=[yoso1 yoso2];

CheckLength('node');%要素の成分の長さで、要素の長さがノードの位置関係と矛盾しないかチェック。矛盾があるときは、ノードに合わせて、長さ成分を変えます。

end