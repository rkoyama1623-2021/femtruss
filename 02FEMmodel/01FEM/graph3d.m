function graph3d(bairitu,varargin)
global node;global yoso;
global delta;
% ===
% graph3d
%�v�Z���ʂ��O���t�ɂ��܂�
%�ψʂ����₷�����邽�߂ɁAbairitu�{���ĕψʂ�\�����܂��B
% syntax
%     graph3d(bairitu)
%     graph3d(bairitu,'y',yoso_i:yoso_j)
%       �`�悷��v�f���w�肵�܂�
%     graph3d(...,'')
% ===

% ===�e�평���ݒ�
disp('==== Draw Graph ====')
N=10;%�v���b�g�Ԋu�i��̗���N�������܂��j

%�ŏ��̗��̈ʒu���v���b�g
hold on%�e�v�f�����ɕ`�悵�ďd�ˍ��킹�Ă����܂��B

fprintf('drawing yoso...')
% ======  �����𐬌`
input=struct('drawNode',zeros(1,size(node,2)),...%�`�悷��m�[�h
    'drawYoso',1:size(yoso,2),...%�`�悷��v�f
    'displacement',1,...%�ό`��`�悷�邩
    'point_ini','ks',...
    'line_ini','k--',...
    'point_disp','rs',...
    'line_disp','r--');

% �������
if nargin~=1
    vargini=1;
    while vargini<=nargin-1%�I�v�V���������̒��g�����ɉ��
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
    
    for i=1:length(yoso(1,:));%i�ԗv�f�̕`��
        drawYoso(i)
    end
    plot3(node(1,:),node(2,:),node(3,:),'ks')%�m�[�h�̍ŏ��̈ʒu�Ƀv���b�g
% ===  ���炩�̃I�v�V����������ꍇ�̏���
else
    % �v�f�̕`��
    for yosoi=input.drawYoso
        drawYoso(yosoi)
    end
    %�@�Ή�����m�[�h�̕`��
    for i=1:size(node,2)
        if input.drawNode(i)
            plot3(node(1,i),node(2,i),node(3,i),input.point_ini)%�m�[�h�̍ŏ��̈ʒu�Ƀv���b�g
        end
    end
end


% ====�@�@���_�Ȃǂ̐ݒ�
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


% ====i�ԗv�f�̕`�� ===%
function drawYoso(i)
    fprintf('%d ',i)

    %�m�[�h���W���擾
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


    %�ό`�O�̕`��
    plot3(...
    [node(1,nodei) node(1,nodej)],...
    [node(2,nodei) node(2,nodej)],...
    [node(3,nodei) node(3,nodej)],input.line_ini)%�m�[�h���Ȃ�


    %�v�f�ɉ������_�񐶐��i�Ǐ����W�ł���x����̓_��j
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
        %%%%%%%%%% �ό`���`�� %%%%%%%%%%%%%%%%%
        L=yoso(3,i);
        R=zahyo(nodei,nodej);%Global���W��Local���W�֕ϊ�����s��

        %�Ǐ����W�n�ŕψʂ��v�Z
        if L~=0
            x=0:L/N:L;%�Ǐ����W�ɂ����邘���W
        else
            x=zeros(1,N+1);
        end
        deltaI=delta(1+6*(nodei-1):6*nodei);%global���W�ɂ�����ړ_i�̕ψ�
        deltaJ=delta(1+6*(nodej-1):6*nodej);%global���W�ɂ�����ړ_j�̕ψ�
        deltaG=[deltaI;deltaJ];%�v�fi�̃m�[�hi,j��global���W�ɂ�����ψ�

        deltaL=hokan(x,R*deltaG,L);%�Ǐ����Wx�ɂ�����ψ�(u,y,z,ph,th,ps)

        dx=deltaL(1,:);%�Ǐ����Wu�ψ�
        dy=deltaL(2,:);%�Ǐ����Wy�ψ�=�Ǐ����W�ɂ�����y���W(�ʒu)
        dz=deltaL(3,:);%�Ǐ����Wz�ψ�=�Ǐ����W�ɂ�����z���W(�ʒu)

        Rxyz=R(1:3,1:3)';%�Ǐ����W�ɂ�����xyz���W��global���W�ł̍��W�ɕϊ�����s��
        temp=Rxyz*[dx;dy;dz]*bairitu;%global���W�ɂ�����ψ�
        xg=temp(1,:)+xn;%global���W�ɂ�����ψ�dx+global���W�ɂ�����ŏ��̈ʒuxn=global���W�ɂ�����ό`��̈ʒu
        yg=temp(2,:)+yn;%global���W�ɂ�����ψ�dy+global���W�ɂ�����ŏ��̈ʒuyn=global���W�ɂ�����ό`��̈ʒu
        zg=temp(3,:)+zn;%global���W�ɂ�����ψ�dz+global���W�ɂ�����ŏ��̈ʒuzn=global���W�ɂ�����ό`��̈ʒu

        if input.displacement==1
            plot3(xg,yg,zg,input.line_disp);%�ό`���Ă������`��
        elseif input.displacement==2
            plot3([xg(1) xg(N+1)],[yg(1) yg(N+1)],[zg(1) zg(N+1)],input.line_disp);%�ό`��̃m�[�h��`��P
        end
        plot3(xg(1),yg(1),zg(1),input.point_disp);%�ό`��̃m�[�h��`��P
        plot3(xg(N+1),yg(N+1),zg(N+1),input.point_disp);%�ό`��̃m�[�h��`��Q
        
        %axis([-1.5*L 1.5*L -1.5*L 1.5*L])
    end
end
end
