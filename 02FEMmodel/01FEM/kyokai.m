function kyokai(i,x,y,z,ph,th,ps)
%係数行列mat,定数ベクトルbで表わされる連立一次方程式を受け取る。
%i番目の変数を境界値x,y,z,ph,th,psにする。
%新しい係数行列と定数ベクトルを返す。mat2とb2
% syntax kyokai(node_i,x,y,z,ph,th,ps)
% 境界条件を与えない変数は'n'とする。

global K; global F;
global node;

if i>length(node(1,:))
	printf('Error(kyokai):the node you choose does not exist!\n\n\n');
	F=0;K=0;
end

i=6*(i-1)+1;

if x~='n'
    [mat, b]=kyokai2(K,F,i,x);
else
    mat=K;
    b=F;
end
if y~='n'
    [mat,b]=kyokai2(mat,b,i+1,y);
end
if z~='n'
    [mat, b]=kyokai2(mat,b,i+2,z);
end
if ph~='n'
    [mat, b]=kyokai2(mat,b,i+3,ph);
end
if th~='n'
    [mat, b]=kyokai2(mat,b,i+4,th);
end
if ps~='n'
    [mat, b]=kyokai2(mat,b,i+5,ps);
end

K=mat;
F=b;

end




function [mat2,b2]=kyokai2(mat,b,i,a)
%係数行列mat,定数ベクトルbで表わされる連立一次方程式を受け取る。
%i番目の変数を境界値aにする。
%新しい係数行列と定数ベクトルを返す。mat2とb2
mat2temp=mat;%引数格納
b2temp=b;%引数格納

% step1:係数i行目をゼロ、定数i行目をa
mat2temp(i,:)=0;%i行目ゼロ
b2temp(i)=a;

% step2:係数i列目のa倍を右辺へ
b2temp=b2temp-a*mat(:,i);

% step3:係数i行目をii成分以外０．ii成分は１
mat2temp(:,i)=0;%i列目ゼロ
mat2temp(i,i)=1;%ii成分１

% 戻り値を返す
mat2=mat2temp;
b2=b2temp;

end