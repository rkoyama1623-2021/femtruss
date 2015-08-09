% ===
% stress
%     ���͂��v�Z���܂�
%     syntax
%         [sigma_max,yoso_i]=stress(option 'ps')
%             �S�v�f�ɂ��Ď剞�͂����߁A�ő�l��Ԃ��܂�
%         [tau_max,yoso_i]=stress(...,'t')
%             �S�v�f�ɂ��Ď噒�f�͂����߁A�ő�l��Ԃ��܂�
%         [sigma]=stress(...,'mieses')
%             �S�v�f�ɂ��ă~�[�[�X���͂����߁A�ő�l��Ԃ��܂�
%         [...]=stress(...,option 'N',10)
%             ���͌v�Z������ۂ̗v�f�̕�������ݒ肵�܂��B��ł�10�������Čv�Z�B
%         [...]=stress(1:18)
%             ���͂����߂�v�f���x�N�g���ŗ^���܂�
%         [sigma]=stress(...,'distribution')
%             �e�v�f�ɂ�����剞��[�噒�f����]�̕��z�𑽎����z��ŕԂ��܂�
%             [sigma]=stress(...,'distribution','detail')
%             [sigma]��[���͗R���̐�������,�Ȃ��R���̐�������,����R���̙��f����]'��\���������z��
% ===
function [varargout]=stress2(varargin)
global node;	global yoso;
global heatedYoso;

%input�\���́E�E�E�������i�[���܂�
input=struct(...
    'OuRyoku','ps',...
    'N',2,...
    'Yoso',1:size(yoso,2),...
    'distribution',0,...%�v�f���̕��z��m�肽����
    'detail',0,...
    'each',0);%�e�v�f�̍ő剞�͂�m�肽����
%�����̉��
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

%�v�f��������ׂ�
for yosoi=input.Yoso
    %�Ώۗv�f�̉��M���x�𓾂�
    [row,col]=find(heatedYoso(1,:)==yosoi);%heatedYoso��1�s�ڂ�yosoi�����邩���肵����΂��̐��`�C���f�b�N�X��Ԃ�
    if isempty(col)==1%���������ꍇ�A[]���Ԃ����
        temp=0;
    else%�������ꍇ���̈ʒu�𓾂�
        temp=heatedYoso(2,col);
    end
    
    %�Ώۗv�f�̃p�����[�^�[�𓾂�
    %�m�[�h���W���擾
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
    
    %�Ǐ����W�n�ɂ�����ψ�
    deltaLocal=displacement(yosoi,'local');
    
    %Local���W�̈ʒux�ɂ�����׏d�����߂�
    %�ʒu����x=0~x=L�܂ł������������āA�e�X�̈ʒu�ɂ�����׏d���Z�o
    xVector=0:L/input.N:L;
    
    FLocal=zeros(4,length(xVector));%�׏d4���������ɕ��ׂ��s��[Fx,Mz,My,Mx]'
    for i=1:length(xVector)
        x=xVector(i);
        C=...
        [-(A*E)/L,0,0,0,0,0,(A*E)/L,0,0,0,0,0;... 
        0,E*I*((12*x)/L^3-6/L^2),0,0,0,E*I*((6*x)/L^2-4/L),0,E*I*(6/L^2-(12*x)/L^3),0,0,0,E*I*((6*x)/L^2-2/L);... 
        0,0,E*I*(6/L^2-(12*x)/L^3),0,E*I*((6*x)/L^2-4/L),0,0,0,E*I*((12*x)/L^3-6/L^2),0,E*I*((6*x)/L^2-2/L),0;... 
        0,0,0,-(Ip*G)/L,0,0,0,0,0,(Ip*G)/L,0,0] ;

        FLocal(:,i)=C*deltaLocal-alpha*E*A*temp*[1,0,0,0]';
    end
    
    %�f�ʌW�������߁A����𐬕��Ƃ���s�񐶐�
    Z=I/r;
    Zp=Ip/r;
    
    %[Fx,Mx,Myz]'�����߂܂�
    FLocal2=[FLocal(1,:);FLocal(4,:);(FLocal(2,:).^2+FLocal(3,:).^2).^(1/2)];
    % �f�ʌW�����x�N�g���ɂ��܂�
    Zmat=[A Zp Z]'*ones(1,length(xVector));
    
    %�������͂ƙ��f���͂����߂܂�
    sigmaVector(:,:,yosoi)=FLocal2./Zmat;%�C�ӂ̈ʒu�ɂ��鉞��3�����@Fx Mx Myz�ɑΉ����鉞��
    
    %�������͂ƙ��f���͂̍��͂����߂܂�
    sigma=abs(sigmaVector(1,:,yosoi))+abs(sigmaVector(3,:,yosoi));
    tau=abs(sigmaVector(2,:,yosoi));
    
    
    % �Ώۂ̗v�f���ŉ��͕��z�����߂�
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
if input.distribution %�e�v�f���̉��͕��z��m�肽����
    if input.detail
        varargout{1}=sigmaVector(:,:,input.Yoso);
    else
        varargout{1}=ouRyoku(:,:,input.Yoso);
    end
elseif input.each     % �e�v�f���Ƃ̍ő剞�͂�m�肽����
    varargout{1}=ouRyoku_max;
    varargout{2}=yosoi_max;
else                  % ���ׂĂ̗v�f�̒��ōő�̉��͂�m�肽����
    [a,b]=max(ouRyoku_max);
    varargout{1}=a;
    varargout{2}=b;
    
end