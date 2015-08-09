% =============================
% displacement
% syntax:
%     displacement(nodei)     nodei番ノードのglobal変位
%     displacement(nodei,j)   nodei番ノードのglobal変位のj番目の成分
%     displacement(yosoi,'local') yosoi番要素の両端のローカル変位
%     displacement(yosoi,'local',j) yosoi番要素の両端のローカル変位のj番成分
%     displacement([nodei,nodej],'local',...) nodeiとnodejを結ぶ座標で変位を成分表示
% =============================

function deltai=displacement(i,varargin)
global delta;
global yoso;
global nobi;
global deltaRigid;

if nargin==1
    if i==0
        if exist('deltaRigid','var')
            deltai=deltaRigid(1:6);
        else
            delta0=zeros(6);
            for i=1:6
                delta0(:,i)=delta(1+6*(i-1):6*i);
            end
            deltai=sum(delta0,2)/6;
        end
    else
        %sprintf('displacement of node(%d) is\n',nodei)
        deltai=delta(1+6*(i-1):6*i);
    end
elseif varargin{1}~='local'
    deltai=delta(6*(i-1)+varargin{1});
elseif varargin{1}=='local'
    if size(i,2)==1
        % ノード番号取得
        nodei=yoso(1,i);
        nodej=yoso(2,i);
    elseif size(i,2)==2;
        nodei=i(1);
        nodej=i(2);
    end

    % ノードの変位(global)を取得
    di=displacement(nodei);
    dj=displacement(nodej);

    % 変位をローカルに変換
    dij=zahyo(nodei,nodej)*[di;dj];
    
    if nargin~=3
        deltai=dij;
    elseif nargin==3
        deltai=dij(varargin{2});
    end
end
end
