function Kgbig=kakudai2(Kg,i,j,n)
% ===============================================
% file name:kakudai2
% detail:
% i番ノードとj番ノードの間のばね定数を
% 全体のばね定数へ拡大します。
% iとjの順番に注意してください！
% ===============================================
global node;
global yoso;
global dof;

    %ばね行列を小行列に分解
	Kgii=Kg(1:dof,1:dof);
	Kgij=Kg(1:dof,dof+1:2*dof);
	Kgji=Kg(dof+1:2*dof,1:dof);
	Kgjj=Kg(dof+1:dof*2,dof+1:2*dof);
	
	%拡大行列の枠を作ります
	Kgbigtemp=zeros(n,n);
	
	Kgbigtemp(1+dof*(i-1):dof*(i),1+dof*(i-1):dof*(i))=Kgii;
	Kgbigtemp(1+dof*(i-1):dof*(i),1+dof*(j-1):dof*(j))=Kgij;
	Kgbigtemp(1+dof*(j-1):dof*(j),1+dof*(i-1):dof*(i))=Kgji;
	Kgbigtemp(1+dof*(j-1):dof*(j),1+dof*(j-1):dof*(j))=Kgjj;
	
	Kgbig=Kgbigtemp;


end