% =============================
% displacement
% syntax:
%     displacement(nodei)     nodei�ԃm�[�h��global�ψ�
%     displacement(nodei,j)   nodei�ԃm�[�h��global�ψʂ�j�Ԗڂ̐���
%     displacement(yosoi,'local') yosoi�ԗv�f�̗��[�̃��[�J���ψ�
%     displacement(yosoi,'local',j) yosoi�ԗv�f�̗��[�̃��[�J���ψʂ�j�Ԑ���
%     displacement([nodei,nodej],'local',...) nodei��nodej�����ԍ��W�ŕψʂ𐬕��\��
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
        % �m�[�h�ԍ��擾
        nodei=yoso(1,i);
        nodej=yoso(2,i);
    elseif size(i,2)==2;
        nodei=i(1);
        nodej=i(2);
    end

    % �m�[�h�̕ψ�(global)���擾
    di=displacement(nodei);
    dj=displacement(nodej);

    % �ψʂ����[�J���ɕϊ�
    dij=zahyo(nodei,nodej)*[di;dj];
    
    if nargin~=3
        deltai=dij;
    elseif nargin==3
        deltai=dij(varargin{2});
    end
end
end
