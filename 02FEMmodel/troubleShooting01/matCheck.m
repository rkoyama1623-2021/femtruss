% =========================
% 行列のｚ軸対象性をチェックします。
% 3行6列or6行６列のベクトルについて検査し、
% 
% =========================



function [eps,matEps]=matCheck(mat)
% disp('checking symmetry of mat')

mat2=zeros(size(mat));
for i=1:6
th=2*pi/3;
Rz=...
[cos(th) -sin(th)   0;...
 sin(th) cos(th)    0;...
       0       0    1];%z軸周りの回転変換

% 3行の場合
if size(mat,1)==3
    R=Rz;
end
% 6行の場合
if size(mat,1)==6
    R=zeros(size(mat,1),6);
    R(1:3,1:3)=Rz;
    R(4:6,4:6)=Rz;
end

mat2(:,1+mod(i+1,6))=R*mat(:,i);

end

% disp('mat=')
% mat
% disp('mat2=')
% mat2
% disp('mat2-mat=')
% mat2-mat

% eps=norm(mat2-mat)
matEps=abs(mat2-mat)./mat;
eps=max(max(matEps));



end