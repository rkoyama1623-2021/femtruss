function tempSetting(i,temp)
% tempSetting(yoso_i,temperature)
%�v�f�ԍ�i��temp[��]���߂܂��B
%B'[EI 0;0 AE]�����߂܂�(maxima �ŋ��߂Ă����B)
global yoso
global heatedYoso

%heatedYoso�ɉ��߂�v�f��o�^
if heatedYoso(1)==0%���߂Ă̓o�^
    heatedYoso=[i,temp]';
else%2��ڈȍ~
    colN=size(heatedYoso(2));
    newHeatedYoso=[i,temp]';
    heatedYoso=[heatedYoso newHeatedYoso];
end


nodei=yoso(1,i);
nodej=yoso(2,i);

L=yoso(3,i);
A=yoso(4,i);
E=yoso(7,i);
alpha=yoso(9,i);



fL=alpha*temp.*[-A*E,0,0,0,0,0,A*E,0,0,0,0,0]';%�Ǐ����W�ɂ�����ړ_�׏d(maxima�Ōv�Z�������ɑ�����Ă���)
R=zahyo(nodei,nodej);
fG=R'*fL;%�Ǐ����W�ɂ�����ړ_�׏d��global���W�ɕϊ�

forceApply(nodei,fG(1),fG(2),fG(3),fG(4),fG(5),fG(6));
forceApply(nodej,fG(7),fG(8),fG(9),fG(10),fG(11),fG(12));

end