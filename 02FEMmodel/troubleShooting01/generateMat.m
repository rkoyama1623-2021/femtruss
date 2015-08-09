% ========================================================
% ファイル名：ellipsoid1
% 内容：
% 感度行列を受け取り、可操作楕円体を描画します。
% 
% 
% 
% 
% ========================================================

function [myMat,A]=generateMat(sr,thp,br,thb,pb,phi,theta,psi,param1,param2,param3)
myPath;


global node;	global yoso;
global dof;
global K;		global F;
global K0;	global F0;
global delta;
global mat;

%感度マトリックスを生成

%%%%%%%%%%%%% ノードの設定 %%%%%%%%%%%%%%%%
%node行列と要素行列を生成します。

% param0=[sr,thp,br,thb,pb,phi,theta,psi]

%ノードの位置関係

%ノードと要素の生成
generateYosoAndNode(sr,thp,br,thb,pb,phi,theta,psi,param1,param2,param3);

mat=zeros(6,6);%感度マトリックスの下地

printf('Creat matrix of system      ')

for i=1:6
    %有限要素法の準備
    maesyori;
    %荷重条件の設定
    tempSetting(6+i,1);
    %境界条件(ベースをすべて拘束)
    boundary;
    %変位を計算する
    solveDelta
    %プレート中心の変位
    mat(:,i)=plateCenter();
    printf('*')
end
printf('\n\n')

%可操作楕円体を生成
J1=mat(1:3,:);
J2=mat(4:6,:);
myMat=mat;
% J2inv=pinv(J2')'%pinvは縦長行列にしか適用できないため、転置の疑似逆行列を求めてから転置している。
% A=J2inv'*J2inv
% [P,V]=drawEllipsoid(A)


J1inv=pinv(J1')';%pinvは縦長行列にしか適用できないため、転置の疑似逆行列を求めてから転置している。
A=J1inv'*J1inv;











end