% ===
% stress
%     応力を計算します
%     syntax
%         [sigma_max,yoso_i]=stress(option 'ps')
%             全要素について主応力を求め、最大値を返します
%         [tau_max,yoso_i]=stress(...,'t')
%             全要素について主剪断力を求め、最大値を返します
%         [sigma]=stress(...,'mieses')
%             全要素についてミーゼス応力を求め、最大値を返します
%         [...]=stress(...,option 'N',10)
%             応力計算をする際の要素の分割数を設定します。例では10等分して計算。
%         [...]=stress(1:18)
%             応力を求める要素をベクトルで与えます
%         [sigma]=stress(...,'distribution')
%             各要素における主応力[主剪断応力]の分布を多次元配列で返します
%             [sigma]=stress(...,'distribution','detail')
%             [sigma]は[軸力由来の垂直応力,曲げ由来の垂直応力,捩り由来の剪断応力]'を表す多次元配列
% ===
function [varargout]=stress2(varargin)
global node;	global yoso;
global heatedYoso;

%input構造体・・・引数を格納します
input=struct(...
    'OuRyoku','ps',...
    'N',2,...
    'Yoso',1:size(yoso,2),...
    'distribution',0,...%要素内の分布を知りたい時
    'detail',0,...
    'each',0);%各要素の最大応力を知りたい時
%引数の解析
if nargin>0
    vargini=1;
    while vargini<=nargin
        switch varargin{vargini}
            case 'ps'
                vargini=vargini+1;
            case 'pt'
                input.OuRyoku='t';
                vargini=vargini+1;
            case 's'
                input.OuRyoku='s';
                vargini=vargini+1;
            case 't'
                input.OuRyoku='t';
                vargini=vargini+1;
            case 'mieses'
                input.OuRyoku='mieses';
                vargini=vargini+1;
            case 'N'
                input.N=varargin{vargini+1};
                vargini=vargini+2;
            case 'yoso'
                input.Yoso=varargin{vargini+1};
                vargini=vargini+2;
            case 'distribution'
                input.distribution=1;
                if vargini<nargin & strcmp(varargin{vargini+1},'detail')
                    input.detail=1;
                    vargini=vargini+2;
                else
                    vargini=vargini+1;
                end
            case 'each'
                input.each=1;
                vargini=vargini+1;
            otherwise
                input.Yoso=varargin{vargini};
                vargini=vargini+1;
        end
    end
end

ouRyoku=zeros(1,input.N+1,size(input.Yoso,2));
ouRyoku_max=zeros(1,size(input.Yoso,2));

%要素を一つずつ調べる
for yosoi=input.Yoso
    %対象要素の加熱温度を得る
    [row,col]=find(heatedYoso(1,:)==yosoi);%heatedYosoの1行目にyosoiがあるか判定しあればその線形インデックスを返す
    if isempty(col)==1%無かった場合、[]が返される
        temp=0;
    else%あった場合その位置を得る
        temp=heatedYoso(2,col);
    end
    
    %対象要素のパラメーターを得る
    %ノード座標を取得
    %[A I Ip E G alpha rho]
    nodei=yoso(1,yosoi);
    nodej=yoso(2,yosoi);
    L=yoso(3,yosoi);
    A=yoso(4,yosoi);
    I=yoso(5,yosoi);
    Ip=yoso(6,yosoi);
    E=yoso(7,yosoi);
    G=yoso(8,yosoi);
    alpha=yoso(9,yosoi);
    rho=yoso(10,yosoi);
    r=yoso(11,yosoi);
    
    %局所座標系における変位
    deltaLocal=displacement(yosoi,'local');
    
    %Local座標の位置xにおける荷重を求める
    %位置ｘはx=0~x=Lまでを何等分かして、各々の位置における荷重を算出
    xVector=0:L/input.N:L;
    
    FLocal=zeros(4,length(xVector));%荷重4成分を横に並べた行列[Fx,Mz,My,Mx]'
    for i=1:length(xVector)
        x=xVector(i);
        C=...
        [-(A*E)/L,0,0,0,0,0,(A*E)/L,0,0,0,0,0;... 
        0,E*I*((12*x)/L^3-6/L^2),0,0,0,E*I*((6*x)/L^2-4/L),0,E*I*(6/L^2-(12*x)/L^3),0,0,0,E*I*((6*x)/L^2-2/L);... 
        0,0,E*I*(6/L^2-(12*x)/L^3),0,E*I*((6*x)/L^2-4/L),0,0,0,E*I*((12*x)/L^3-6/L^2),0,E*I*((6*x)/L^2-2/L),0;... 
        0,0,0,-(Ip*G)/L,0,0,0,0,0,(Ip*G)/L,0,0] ;

        FLocal(:,i)=C*deltaLocal-alpha*E*A*temp*[1,0,0,0]';
    end
    
    %断面係数を求め、それを成分とする行列生成
    Z=I/r;
    Zp=Ip/r;
    
    %[Fx,Mx,Myz]'を求めます
    FLocal2=[FLocal(1,:);FLocal(4,:);(FLocal(2,:).^2+FLocal(3,:).^2).^(1/2)];
    % 断面係数をベクトルにします
    Zmat=[A Zp Z]'*ones(1,length(xVector));
    
    %垂直応力と剪断応力を求めます
    sigmaVector(:,:,yosoi)=FLocal2./Zmat;%任意の位置にける応力3成分　Fx Mx Myzに対応する応力
    
    %垂直応力と剪断応力の合力を求めます
    sigma=abs(sigmaVector(1,:,yosoi))+abs(sigmaVector(3,:,yosoi));
    tau=abs(sigmaVector(2,:,yosoi));
    
    
    % 対象の要素内で応力分布を求める
    switch input.OuRyoku
        case 'ps'
            s1=0.5*sigma+sqrt((0.5.*sigma).^2+tau.^2);
            ouRyoku(1,:,yosoi)=s1;
            [ouRyoku_max(yosoi),yosoi_max]=max(ouRyoku(:,:,yosoi));
        case 'pt'
            t1=sqrt((0.5.*sigma).^2+tau.*tau);
            ouRyoku(1,:,yosoi)=t1;
            [ouRyoku_max(yosoi),yosoi_max]=max(ouRyoku(:,:,yosoi));
        case 's'
            ouRyoku(1,:,yosoi)=sigma;
            [ouRyoku_max(yosoi),yosoi_max]=max(ouRyoku(:,:,yosoi));
        case 't'
            ouRyoku(1,:,yosoi)=tau;
            [ouRyoku_max(yosoi),yosoi_max]=max(ouRyoku(:,:,yosoi));

        case 'mieses'
            s1=0.5*sigma+sqrt((0.5.*sigma).^2+tau.^2);
            s2=0.5*sigma-sqrt((0.5.*sigma).^2+tau.^2);
            sMieses=sqrt(0.5*((s1-s2).^2+s2.^2+s1.^2));
            ouRyoku(1,:,yosoi)=sMieses;
            [ouRyoku_max(yosoi),yosoi_max]=max(ouRyoku(:,:,yosoi));
    end
    
    
end
if input.distribution %各要素内の応力分布を知りたい時
    if input.detail
        varargout{1}=sigmaVector(:,:,input.Yoso);
    else
        varargout{1}=ouRyoku(:,:,input.Yoso);
    end
elseif input.each     % 各要素ごとの最大応力を知りたい時
    varargout{1}=ouRyoku_max;
    varargout{2}=yosoi_max;
else                  % すべての要素の中で最大の応力を知りたい時
    [a,b]=max(ouRyoku_max);
    varargout{1}=a;
    varargout{2}=b;
    
end