% ========================================
% ファイル名：drawEllipsoid
% 
% 内容：
% x'Ax=1で表される楕円体をグラフに描画します。
% Aは2次元でも3次元でもOK。
% x=Pyとおくと、yでは主軸が、x-y-z方向になります。
% rは楕円体中心座標
% グラフを描画したくないときは、flag=0(flagは省略可)
% 
% 引数1：A,r
% 引数2：A,r,flag
% 戻り値：P,体格化された行列D
% ========================================

function [V,D,plAx]=drawEllipsoid(A,r,varargin)
% A=[1 1 0;1 2 0;0 0 1]

A=(A+A')/2;

len=length(A);%行列Aの次元を調べる。

if isDiag(A)==1&&len==3
V=eye(3);
D=A;
else
[V2,D2]=eig(A);%対角化
%A=V'*D*Vを満たすV,Dを求めます。(Dが対角行列)
% 主軸をxyz軸の順に並べ替え
[D,V]=settle(D2,V2);

end

n=30;
th=0:2*pi/n:2*pi;
ph=0:2*pi/n:2*pi;



% ------------- 2次元楕円の描画 ----------------
if len==2;
a=1/sqrt(D(1,1));
b=1/sqrt(D(2,2));

plAx=[a,b];

if (nargin<=2)|(varargin{1}~=0)
    x=a*cos(th);
    y=b*sin(th);

    temp=V*[x;y];
    x2=temp(1,:);
    y2=temp(2,:);

    if length(r)==2
    x2=x2+r(1);
    y2=y2+r(2);
    end
    
    plot(x2,y2)
end
    
% -----------3次元楕円体の場合の描画---------------
elseif len==3;
ph=0:2*pi/n:2*pi;

%長軸の長さを求めます。
a=1/sqrt(D(1,1));
b=1/sqrt(D(2,2));
c=1/sqrt(D(3,3));

plAx=[a,b,c];

if (nargin<=2)|(varargin{1}==1)
    %角度変化のきめ細かさ
    lenAngle=length(ph);

    %直行化された新たな空間で楕円を描画
    x=a*cos(th)'*ones(1,lenAngle);
    y=b*sin(th)'*cos(ph);
    z=c*sin(th)'*sin(ph);

    %もとの座標系へ戻す変換を行えるように、３＊＿の行列に並べ替え
    v=zeros(3,lenAngle^2);
    k=1;
    for i=1:lenAngle
        for j=1:lenAngle
            v(:,k)=[x(i,j);y(i,j);z(i,j)];
            k=k+1;
        end
    end

    %座標変換
    v=V*v;

    %グラフ描画のための行列を目盛りに割り当て
    x2=zeros(size(x));
    y2=zeros(size(y));
    z2=zeros(size(z));

    %ｖベクトルの成形
    for i=1:lenAngle
        for j=1:lenAngle
            x2(i,j)=v(1,lenAngle*(i-1)+j);
            y2(i,j)=v(2,lenAngle*(i-1)+j);
            z2(i,j)=v(3,lenAngle*(i-1)+j);		
        end
    end

    if length(r)==3
    x2=x2+r(1);
    y2=y2+r(2);
    z2=z2+r(3);
    end


    %グラフの描画

    surf(x2,y2,z2)

    view(3);
    
    %グラフのオプション
    %axis square%グラフを正方形にします
    axis equal;%グラフ軸のスケールを1:1:1に
    title('','fontsize',20); 
    xlabel('x[m]','fontsize',11);
    ylabel('y[m]','fontsize',11);
    zlabel('z[m]','fontsize',11);
end
end

end

function [D3,V3]=settle(D2,V2)

Dvector=diag(D2);

p1=inPlane(V2(:,1));
p2=inPlane(V2(:,2));
p3=inPlane(V2(:,3));



if (p1(3)+p2(3)+p3(3)<3)&(p1(3)+p2(3)+p3(3)>0)
    group1=zeros(4,3);
    group2=zeros(4,3);
    if p1(3)==0
        group1(1:3,1)=V2(:,1);
        group1(4,1)=Dvector(1);
        group1(3,3)=1;
    else
        group2(1:3,1)=V2(:,1);
        group2(4,1)=Dvector(1);
        group2(3,3)=1;
    end
    
    if p2(3)==0
        group1(1:3,group1(3,3)+1)=V2(:,2);
        group1(4,group1(3,3)+1)=Dvector(2);
        group1(3,3)=group1(3,3)+1;
    else
        group2(1:3,group2(3,3)+1)=V2(:,2);
        group2(4,group2(3,3)+1)=Dvector(2);
        group2(3,3)=group2(3,3)+1;
    end

    if p3(3)==0
        group1(1:3,group1(3,3)+1)=V2(:,3);
        group1(4,group1(3,3)+1)=Dvector(3);
        group1(3,3)=group1(3,3)+1;
    else
        group2(1:3,group2(3,3)+1)=V2(:,3);
        group2(4,group2(3,3)+1)=Dvector(3);
        group2(3,3)=group2(3,3)+1;
    end
    
    pl=inPlane(group1(1:3,1));
    if pl(1)==0
        temp=group1(:,1);
        group1(:,1)=group1(:,2);
        group1(:,2)=temp;
    end
    
    if group1(3,3)==2        
        eps=abs((group1(4,1)-group1(4,2))/max(group1(4,1),group1(4,2)));
        if eps<10^-5;
            group1(1:3,1:2)=[1 0 0;0 1 0]';
        end
        
        D3=diag([group1(4,1),group1(4,2),group2(4,1)]);
        V3=[group1(1:3,1:2) group2(1:3,1)];            
            
    else
        D3=D2;
        V3=V2;
    end
else
    D3=D2;
    V3=V2;
end

end

function plain=inPlane(v3)
% ================================
% ベクトルv3がx,y,zのどの軸成分を持っているか判定
% plane=inPlane(v3)
% 例えば,x成分とy成分を持つ場合
% plane=[1 1 0]
% ================================

% 成分があると1
zero=10^-6;
plain=ones(1,3);

v3n=norm(v3);
v3p=abs(v3./v3n);
if v3p(1)<zero
    plain(1)=0;
elseif v3p(2)<zero
    plain(2)=0;
elseif v3p(3)<zero
    plain(3)=0;
end

end
