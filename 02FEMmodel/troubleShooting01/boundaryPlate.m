% ================================================
% �m�[�h�P�`�U�̔����p��]���m�[�h�P�Ɠ������Ȃ�悤�ɍS�����܂��B
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
colmn=K(:,j);%K�̗�x�N�g�����擾�inodei�ԃm�[�h��i�ԗv�f.�ȉ��u�Ώەϐ��v�ƌĂԁj
K(:,j)=zeros(length(K(1,:)),1);

K(:,i)=K(:,i)+colmn;%�Ώەϐ��̌W�����m�[�h�P�̌W���ɓ���
K(j,i)=1;
K(j,j)=-1;
F(j)=0;

end
end