% =======================================================
% file: plAxes
% detail:
% ����ȉ~�̂�^����s��A���󂯂Ƃ�A
% �Ίp�s��ɂȂ��Ă��邩���ׂ���A�厲�̒�����Ԃ��܂��B
% drawEllipsoid�֐��Ƃقړ����ł��B
% 
% input: A(�ȉ~�̂�^����3�~�R�̍s��)
% output:[a b c](�厲�̒���)
% =======================================================
function func=plAxes(A)

A=(A+A')/2;

if isDiag(A)==1
D=A;
else
[V,D]=eig(A);%�Ίp��
%A=V'*D*V�𖞂���V,D�����߂܂��B(D���Ίp�s��)
end

%�����̒��������߂܂��B
a=1/sqrt(D(1,1));
b=1/sqrt(D(2,2));
c=1/sqrt(D(3,3));

func=[a b c];

end