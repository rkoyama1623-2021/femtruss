function graph3d(bairitu,varargin)
global node;global yoso;
global delta;
% ===
% graph3d
%計算結果をグラフにします
%変位を見やすくするために、bairitu倍して変位を表示します。
% syntax
%     graph3d(bairitu)
%     graph3d(bairitu,'y',yoso_i:yoso_j)
%       描画する要素を指定します
%     graph3d(...,'')
% ===

% ===各種初期設定
disp('==== Draw Graph ====')
N=10;%プロット間隔（一つの梁をN等分します）

%最初の梁の位置をプロット
hold on%各要素を順に描画して重ね合わせていきます。

fprintf('drawing yoso...')
% ======  引数を成形
input=struct('drawNode',zeros(1,size(node,2)),...%描画するノード
    'drawYoso',1:size(yoso,2),...%描画する要素
    'displacement',1,...%変形を描画するか
    'point_ini','ks',...
    'line_ini','k--',...
    'point_disp','rs',...
    'line_disp','r--');

% 引数解析
if nargin~=1
    vargini=1;
    while vargini<=nargin-1%オプション引数の中身を順に解析
        if strcmp(varargin{vargini},'y')
            input.drawYoso=varargin{vargini+1};
            vargini=vargini+2;
        elseif strcmp(varargin{vargini},'w')
            input.displacement=0;
            vargini=vargini+1;
        elseif strcmp(varargin{vargini},'w2')
            input.displacement=2;
            vargini=vargini+1;
        elseif strcmp(varargin{vargini},'point_ini')
            input.point_ini=varargin{vargini+1};
            vargini=vargini+2;
        elseif strcmp(varargin{vargini},'line_ini')
            input.line_ini=varargin{vargini+1};
            vargini=vargini+2;
        elseif strcmp(varargin{vargini},'point_disp')
            input.point_disp=varargin{vargini+1};
            vargini=vargini+2;
        elseif strcmp(varargin{vargini},'line_disp')
            input.line_disp=varargin{vargini+1};
            vargini=vargini+2;
        else
            disp('error:graph3d. input is in valid!')
            input.drawYoso=[];
            break;
        end
    end
end

if nargin==1
    
    for i=1:length(yoso(1,:));%i番要素の描画
        drawYoso(i)
    end
    plot3(node(1,:),node(2,:),node(3,:),'ks')%ノードの最初の位置にプロット
% ===  何らかのオプションがある場合の処理
else
    % 要素の描画
    for yosoi=input.drawYoso
        drawYoso(yosoi)
    end
    %　対応するノードの描画
    for i=1:size(node,2)
        if input.drawNode(i)
            plot3(node(1,i),node(2,i),node(3,i),input.point_ini)%ノードの最初の位置にプロット
        end
    end
end


% ====　　視点などの設定
%legend('before','after');
axis equal;
%axis([0 1 0 1 0 1])
view(3);

hold off;
xlabel('x[m]','fontsize',11);
ylabel('y[m]','fontsize',11);
zlabel('z[m]','fontsize',11);


%x=0:L/10:L;
%y=zeros(1,length(x))
%u=dx
%v=dy
%figure
%quiver(x,y,u,v)

disp('Graph has drawn.')


% ====i番要素の描画 ===%
function drawYoso(i)
    fprintf('%d ',i)

    %ノード座標を取得
    nodei=yoso(1,i);
    nodej=yoso(2,i);
    input.drawNode(nodei)=1;
    input.drawNode(nodej)=1;

    xi=node(1,nodei);
    xj=node(1,nodej);
    yi=node(2,nodei);
    yj=node(2,nodej);
    zi=node(3,nodei);
    zj=node(3,nodej);


    %変形前の描画
    plot3(...
    [node(1,nodei) node(1,nodej)],...
    [node(2,nodei) node(2,nodej)],...
    [node(3,nodei) node(3,nodej)],input.line_ini)%ノードをつなぐ


    %要素に沿った点列生成（局所座標でいうx軸上の点列）
    if xj-xi==0
        xn=xi*ones(1,N+1);
    else
        xn=xi:(xj-xi)/N:xj;
    end

    if yj-yi==0
        yn=yi*ones(1,N+1);
    else
        yn=yi:(yj-yi)/N:yj;
    end

    if zj-zi==0
        zn=zi*ones(1,N+1);
    else
        zn=zi:(zj-zi)/N:zj;
    end

    if input.displacement~=0
        %%%%%%%%%% 変形後を描画 %%%%%%%%%%%%%%%%%
        L=yoso(3,i);
        R=zahyo(nodei,nodej);%Global座標をLocal座標へ変換する行列

        %局所座標系で変位を計算
        if L~=0
            x=0:L/N:L;%局所座標におけるｘ座標
        else
            x=zeros(1,N+1);
        end
        deltaI=delta(1+6*(nodei-1):6*nodei);%global座標における接点iの変位
        deltaJ=delta(1+6*(nodej-1):6*nodej);%global座標における接点jの変位
        deltaG=[deltaI;deltaJ];%要素iのノードi,jのglobal座標における変位

        deltaL=hokan(x,R*deltaG,L);%局所座標xにおける変位(u,y,z,ph,th,ps)

        dx=deltaL(1,:);%局所座標u変位
        dy=deltaL(2,:);%局所座標y変位=局所座標におけるy座標(位置)
        dz=deltaL(3,:);%局所座標z変位=局所座標におけるz座標(位置)

        Rxyz=R(1:3,1:3)';%局所座標におけるxyz座標をglobal座標での座標に変換する行列
        temp=Rxyz*[dx;dy;dz]*bairitu;%global座標における変位
        xg=temp(1,:)+xn;%global座標における変位dx+global座標における最初の位置xn=global座標における変形後の位置
        yg=temp(2,:)+yn;%global座標における変位dy+global座標における最初の位置yn=global座標における変形後の位置
        zg=temp(3,:)+zn;%global座標における変位dz+global座標における最初の位置zn=global座標における変形後の位置

        if input.displacement==1
            plot3(xg,yg,zg,input.line_disp);%変形している梁を描画
        elseif input.displacement==2
            plot3([xg(1) xg(N+1)],[yg(1) yg(N+1)],[zg(1) zg(N+1)],input.line_disp);%変形後のノードを描画１
        end
        plot3(xg(1),yg(1),zg(1),input.point_disp);%変形後のノードを描画１
        plot3(xg(N+1),yg(N+1),zg(N+1),input.point_disp);%変形後のノードを描画２
        
        %axis([-1.5*L 1.5*L -1.5*L 1.5*L])
    end
end
end
