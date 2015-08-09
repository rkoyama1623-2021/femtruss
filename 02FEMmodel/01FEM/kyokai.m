function kyokai(i,x,y,z,ph,th,ps)
%�W���s��mat,�萔�x�N�g��b�ŕ\�킳���A���ꎟ���������󂯎��B
%i�Ԗڂ̕ϐ������E�lx,y,z,ph,th,ps�ɂ���B
%�V�����W���s��ƒ萔�x�N�g����Ԃ��Bmat2��b2
% syntax kyokai(node_i,x,y,z,ph,th,ps)
% ���E������^���Ȃ��ϐ���'n'�Ƃ���B

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
%�W���s��mat,�萔�x�N�g��b�ŕ\�킳���A���ꎟ���������󂯎��B
%i�Ԗڂ̕ϐ������E�la�ɂ���B
%�V�����W���s��ƒ萔�x�N�g����Ԃ��Bmat2��b2
mat2temp=mat;%�����i�[
b2temp=b;%�����i�[

% step1:�W��i�s�ڂ��[���A�萔i�s�ڂ�a
mat2temp(i,:)=0;%i�s�ڃ[��
b2temp(i)=a;

% step2:�W��i��ڂ�a�{���E�ӂ�
b2temp=b2temp-a*mat(:,i);

% step3:�W��i�s�ڂ�ii�����ȊO�O�Dii�����͂P
mat2temp(:,i)=0;%i��ڃ[��
mat2temp(i,i)=1;%ii�����P

% �߂�l��Ԃ�
mat2=mat2temp;
b2=b2temp;

end