global node;	global yoso;
global dof;
global K;		global F;
global K0;	global F0;
global delta;
global heatedYoso

title='��_{p}&��_{b} '
mode='w2'



%�m�[�h�̈ʒu�֌W

paramSetting2;


n=10;
matX=zeros(n,1);
matPlAx=zeros(n,2);
matDet=zeros(n,1);
matV=zeros(3,3,n);

varMin=10;
varMax=50;
for i=1:n
    
   param1=[A1 I1 Ip1 E1 G1 alpha1 rho1 r1];
   param2=[A2 I2 Ip2 E2 G2 alpha2 rho2 r2];
   param3=[A3 I3 Ip3 E3 G3 alpha3 rho3 r3];
   var=varMin+(varMax-varMin)*i/n;
   
   matX(i)=var;
   % sr,thp,br,thb,pb,alphaLeg,phi,theta,psi,param1,param2,param3
   [plAx,matV(:,:,i),J]=ellipsoidSizeFEM(sr,var,br,thb,pb,alphaLeg,phi,theta,psi,param1,param2,param3,mode);
   
   eps=abs(plAx(2)-plAx(1))/max(plAx(1),plAx(2));
   if eps>10^-6
       fprintf('\nError:parametricEffects. Axis length is not same.%f',log10(eps))
   end
   
   matPlAx(i,:)=plAx(2:3);
   matDet(i)=abs(det(J));
   
   fprintf('*')
   if mod(i,20)==0
       fprintf('\n')
   end
   
end

% �O���t�`��
[AX,H1,H2] =plotyy([matX,matX],matPlAx,...
    matX,matDet,...
    'plot','plot');

% ���ڐ��̐ݒ�
set(AX(1),'FontSize',15)
set(AX(2),'FontSize',15)
set(AX(2),'YTick',[-inf,inf]);

% axis(AX(1),[-inf,inf,-inf,inf])


if strcmp(mode,'p1')|strcmp(mode,'p2')
    % ����
    axis(AX(1),[-inf,inf,0,20*10^-6])
    set(AX(1),'YTick',[0:2*10^-6:2*10^-5]);
    ylabel(AX(1),'�厲����[m]','FontSize',15)
elseif strcmp(mode,'w1')|strcmp(mode,'w2')
    % �p�x
    axis(AX(1),[-inf,inf,0,30])
    set(AX(1),'YTick',[0:5:30]);
    ylabel(AX(1),'��]�p["]','FontSize',15)
end

axis(AX(2),[-inf,inf,-inf,inf])

set(AX(1),'Box','Off') 

% �O���t�̐ݒ�
set(AX(2),'YColor','k')%���F����
set(get(AX(2),'YLabel'),'Color','k')%���x���̐F������
% set(AX(2),'YScale','log')

hleg=legend('x&y','z','det(J)');%�}��
set(hleg,'Location','NorthWest')
% set(hleg,'Location','NorthEast')

ylabel(AX(2),'����x det(J)','FontSize',15)
xlabel([title '  (' mode ')'],'FontSize',15)