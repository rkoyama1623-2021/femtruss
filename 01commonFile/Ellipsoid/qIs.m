%=========================================================
% ファイル名：qIs
% Syntax:[r,Q]=qIs(J,omega,qsize,opt_flag)
% flag=1のとき、警告を表示
% 内容：
% ヤコビ行列J(3*6)と出力ベクトルOmegaを受け取って、
% Omega=J*q
% の解で大きさがqsizeのqをパラメータ表示するための定数とベクトルを求めます。
% q=J'omega+a1*Q1+a2*Q2+a3*Q3
% と表す。ただし、J'はムーアペンローズの疑似逆行列で、
% Q1~Q3はKerJを張る正規直行ベクトルです。
% このとき、q'q=(J'omega)'*(J'omega)'+a1^2+a2^2+a3^2
% より、a1,a2,a3は球の式を満たします。球の半径をrとして戻り値にします。
% 
% 
% 引数：	J,omega,qSize(Jは6*3の行列),omegaは3行ベクトル,qsizeはqの絶対値
% 
% 戻り：		r,Q(rはa1~a3が乗る球の半径、Qはq1~q3を並べたもの)
% 
%=========================================================

function [r,Q]=qIs(J,omega,qsize,varargin)
Jinv=(pinv(J'))';%ムーアペンローズの疑似逆行列を返します。
Q=null(J);
%球の半径は
temp=qsize'*qsize-(Jinv*omega)'*(Jinv*omega);
r=sqrt(temp);
rnk=rank(Q);
if nargin==4&varargin{1}==1&rnk~=3
    fprintf('qIs:WARNING rank of Jhat is %d instead of 3!----------------------------!!!\n\n',rnk)
end

end