% =======================================================
% file name:crossMat
% detail:
% �s��̗�x�N�g���ǂ����̊O�ς��s��ŕԂ��܂�
% input:A,B
% A,B�͔C�ӂ�3�~n�s��ł��B
% output:C
% C��i��ڂ��AAi�~Bi(Ai,Bi��A,B��i�Ԗڗ�x�N�g��)�ł���s��
% ========================================================

function C=crossMat(A,B)
if size(A)~=size(B)
    disp('ERROR:crossMat. Matrix sizees are different each other.')
    return
end
if size(A,1)~=3
    disp('ERROR:crossMat. You can input only 3-row matrix!')
    return
end
C2=zeros(size(A));
for i=1:size(A,2)
   C2(:,i)=cross(A(:,i),B(:,i)) ;
end
C=C2;
end