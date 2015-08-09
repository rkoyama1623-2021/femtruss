% =======================================================
% file name:crossMat
% detail:
% 行列の列ベクトルどうしの外積を行列で返します
% input:A,B
% A,Bは任意の3×n行列です。
% output:C
% Cはi列目が、Ai×Bi(Ai,BiはA,Bのi番目列ベクトル)である行列
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