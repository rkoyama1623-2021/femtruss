function [plAx,V,mat,myDelta]=ellipsoidSizeFEM(sr,thp,br,thb,pb,alphaLeg,phi,theta,psi,param1,param2,param3,option,varargin)
% ======================================================================
% 可操作楕円体の主軸長さplAx,主軸方向ベクトルV,ヤコビ行列Jを求めます
% syntax:
%    [plAx,V,J]=ellipsoidSizeFEM(sr,thp,br,thb,pb,alphaLeg,phi,theta,psi,param1,param2,param3,option)
%     option:'p1','p2','w1','w2'
%     'p1':角度拘束なしの並進変位の可操作楕円体[m]
%     'p2':角度を拘束した場合の並進可操作楕円体[m]
%     'w1':並進拘束なしの姿勢回転の可操作楕円体[deg]
%     'w2':並進拘束ありの姿勢回転の可操作楕円体[deg]
% ======================================================================

global node;	global yoso;
global dof;
global K;		global F;
global K0;	global F0;
global delta;

% --------------------------  ヤコビ行列生成   ------------------------- %
[sb,bb,sp]=stwertPlatform(sr,thp,br,thb,pb,phi,theta,psi);%stwertPlatformを描画するため。なくてもFEMの計算は可能。
%ノードと要素の生成
generateYosoAndNode2(sr,thp,br,thb,pb,alphaLeg,phi,theta,psi,param1,param2,param3);

mat=zeros(6,6);%感度マトリックスの下地
nNode=size(node,2);
nNodeVertual=nNode-5;
M=zeros(dof*nNode,dof*nNodeVertual);
matPlate=zeros(6,6,6);
for nodei=1:6
% プラットフォーム中心と出力リンクの間の関係を与える座標
    si1=sp(1,nodei);
    si2=sp(2,nodei);
    si3=sp(3,nodei);

    matPlate2=[0 si3 -si2;-si3 0 si1;si2 -si1 0];
    matPlate1=[eye(3) matPlate2;zeros(3) eye(3)];
    matPlate(:,:,nodei)=matPlate1;
    M(1+dof*(nodei-1):dof*nodei,1:6)=matPlate1;
end
M(1+dof*6:dof*nNode,1+dof:dof*nNodeVertual)=eye(dof*(nNodeVertual-1));


mydelta=zeros(size(F,1),6);
for iLeg=1:6
    %有限要素法の準備
    nNode=length(node(1,:));
    nYoso=length(yoso(1,:));
    % ばね定数の重ね合わせ
    K=zeros(dof*nNode,dof*nNode);
    for yosoi=1:18 %足だけについて重ね合わせる
        Kg=bane(yosoi);
        KgBig=kakudai(Kg,yosoi);
        K=K+KgBig;
    end
    
    K0=K;
    F=zeros(dof*nNode,1);
    
    %荷重条件の設定
    tempSetting(6+iLeg,1);
    
    %境界条件(ベースをすべて拘束)
    boundary;
    
    %変位を計算する
    Krigid=M'*K*M;% プラットフォームを剛体にするM
    Frigid=M'*F;
    deltaRigid=Krigid\Frigid;
    delta=M*deltaRigid;
        
    %プレート中心の変位
    mat(:,iLeg)=plateCenter;
    mydelta(:,iLeg)=delta;
%     fprintf('*')
end

myDelta=mydelta;


% グラフの描画について
flag=0;
for counter=1:size(varargin,2)
    flag=flag+strcmp(varargin{counter},'g');    %'g'があればflagは非ゼロ
end

% ---------------------  各種可操作楕円体の長さ計算   ------------------------ %
[plAx,V]=JtoPlAx(mat,option);



end