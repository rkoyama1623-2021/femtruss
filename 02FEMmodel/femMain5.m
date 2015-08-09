% ======================================================================
% file name:femMain5
% detail:
% プラットフォームのFEMモデルからヤコビ行列を求めます
% プレートは完全剛体として、プレート中心の変位に基づいて、
% 各出力リンクの変位を与えます。
% mat=femMain5()
% [delta_plateCenter,delta,Fr,Fall]=femMain5('t',[0,0,0,0,0,0])
% ======================================================================

function [varargout]=femMain5(varargin)
global node;	global yoso;
global dof;
global K;		global F;
global K0;      global F0;
global delta;   global deltaRigid;
global heatedYoso;

dof=6;	%一つの接点が持つ自由度です。今回は並進uvと角度thの３自由度

% 引数の解析
input=struct('t',[0,0,0,0,0,0],'mat',1,'iLegVect',[1:6]);
i=1;
while i<nargin
    switch varargin{i}
        case 't'
            input.mat=0;
            input.t=varargin{i+1};
            input.iLegVect=1:1;% 足を順に加熱した結果を求めることを表します
            i=i+2;
        otherwise
            i=i+1;
    end
end


% ------------------  ノードと要素の生成   -----------------------

% i列目の成分は、i番要素がもつパラメータで、１つ目ノード番号、２つ目ノード番号
%                                   、L、E,G、I、Ip,A、線膨張係数,密度です。
% 列番号がノードの番号です。列ベクトルの成分は、ノードｘ座標、ノードy座標,ノードz座標

paramSetting_final;

param1=[A1 I1 Ip1 E1 G1 alpha1 rho1 r1];
param2=[A2 I2 Ip2 E2 G2 alpha2 rho2 r2];
param3=[A3 I3 Ip3 E3 G3 alpha3 rho3 r3];


%ノードと要素の生成
generateYosoAndNode2(sr,thp,br,thb,pb,alphaLeg,ph,th,ps,param1,param2,param3);


mat=zeros(6,6);%感度マトリックスの下地

% fprintf('Creat matrix of system      ')

nNode=size(node,2);
nNodeVertual=nNode-5;
M=zeros(dof*nNode,dof*nNodeVertual);
matPlate=zeros(6,6,6);
for nodei=1:6
% プラットフォーム中心と出力リンクの間の関係を与える座標
    s=sb(:,nodei)-pb;
    s1=s(1);
    s2=s(2);
    s3=s(3);

    matPlate2=[0 s3 -s2;-s3 0 s1;s2 -s1 0];
    matPlate1=[eye(3) matPlate2;zeros(3) eye(3)];
    matPlate(:,:,nodei)=matPlate1;
    M(1+dof*(nodei-1):dof*nodei,1:6)=matPlate1;
end
M(1+dof*6:dof*nNode,1+dof:dof*nNodeVertual)=eye(dof*(nNodeVertual-1));

for iLeg=input.iLegVect
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
    %加熱要素と加熱温度を記憶する行列
    heatedYoso=zeros(2,1);
    if input.mat
        tempSetting(6+iLeg,1);
    else
        for i=1:6
            tempSetting(6+i,input.t(i))
        end
    end
    %境界条件(ベースをすべて拘束)
    K0=K;
    F0=F;
    boundary;
%     kyokai(2,'n','n','n',0,0,0)
%     kyokai(2,0,0,0,0,0,0)
    
    %変位を計算する(M'の利用)
    Krigid=M'*K*M;% プラットフォームを剛体にするM
    Frigid=M'*F;
%     deltaRigid=Krigid\Frigid;
%     delta=M*deltaRigid;
    
    %pinvの利用
    deltaRigid=pinv(K*M)*F;
    delta=M*deltaRigid;
    %プレート中心の変位
    mat(:,iLeg)=plateCenter;
%     fprintf('*')
    
%     反力等の計算
    Fall=K0*delta;
    Fr=Fall-F0;
    F=Fall;


end

% 戻り値の決定
if input.mat
    varargout{1}=mat;
else
    varargout{1}=plateCenter;
    varargout{2}=delta;
    varargout{3}=Fr;
    varargout{4}=Fall;
end

% plAx=JtoPlAx(mat,'p2')


end