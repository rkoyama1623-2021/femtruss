global node;	global yoso;
global dof;
global K;		global F;
global K0;	global F0;
global delta;
global heatedYoso

title='θ_{p}&θ_{b} '
mode='w2'



%ノードの位置関係

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

% グラフ描画
[AX,H1,H2] =plotyy([matX,matX],matPlAx,...
    matX,matDet,...
    'plot','plot');

% 軸目盛の設定
set(AX(1),'FontSize',15)
set(AX(2),'FontSize',15)
set(AX(2),'YTick',[-inf,inf]);

% axis(AX(1),[-inf,inf,-inf,inf])


if strcmp(mode,'p1')|strcmp(mode,'p2')
    % 長さ
    axis(AX(1),[-inf,inf,0,20*10^-6])
    set(AX(1),'YTick',[0:2*10^-6:2*10^-5]);
    ylabel(AX(1),'主軸長さ[m]','FontSize',15)
elseif strcmp(mode,'w1')|strcmp(mode,'w2')
    % 角度
    axis(AX(1),[-inf,inf,0,30])
    set(AX(1),'YTick',[0:5:30]);
    ylabel(AX(1),'回転角["]','FontSize',15)
end

axis(AX(2),[-inf,inf,-inf,inf])

set(AX(1),'Box','Off') 

% グラフの設定
set(AX(2),'YColor','k')%軸色を黒
set(get(AX(2),'YLabel'),'Color','k')%ラベルの色を黒に
% set(AX(2),'YScale','log')

hleg=legend('x&y','z','det(J)');%凡例
set(hleg,'Location','NorthWest')
% set(hleg,'Location','NorthEast')

ylabel(AX(2),'可操作度 det(J)','FontSize',15)
xlabel([title '  (' mode ')'],'FontSize',15)