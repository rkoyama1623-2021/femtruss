% ================================================
% ノード１～６の微小角回転をノード１と等しくなるように拘束します。
% 
% 
% 
% ================================================



function boundaryPlate
global node;	global yoso;
global dof;
global K;		global F;
global K0;	global F0;
global delta;
global mat;

nodeS=6;
for nodei=1:5
for i=4:6
j=6*(nodei-1)+i;

i=6*(nodeS-1)+i;

K(j,:)=zeros(1,length(K(1,:)));
colmn=K(:,j);%Kの列ベクトルを取得（nodei番ノードのi番要素.以下「対象変数」と呼ぶ）
K(:,j)=zeros(length(K(1,:)),1);

K(:,i)=K(:,i)+colmn;%対象変数の係数をノード１の係数に統合
K(j,i)=1;
K(j,j)=-1;
F(j)=0;

end
end