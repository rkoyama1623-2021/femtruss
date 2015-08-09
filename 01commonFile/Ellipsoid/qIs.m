%=========================================================
% �t�@�C�����FqIs
% Syntax:[r,Q]=qIs(J,omega,qsize,opt_flag)
% flag=1�̂Ƃ��A�x����\��
% ���e�F
% ���R�r�s��J(3*6)�Əo�̓x�N�g��Omega���󂯎���āA
% Omega=J*q
% �̉��ő傫����qsize��q���p�����[�^�\�����邽�߂̒萔�ƃx�N�g�������߂܂��B
% q=J'omega+a1*Q1+a2*Q2+a3*Q3
% �ƕ\���B�������AJ'�̓��[�A�y�����[�Y�̋^���t�s��ŁA
% Q1~Q3��KerJ�𒣂鐳�K���s�x�N�g���ł��B
% ���̂Ƃ��Aq'q=(J'omega)'*(J'omega)'+a1^2+a2^2+a3^2
% ���Aa1,a2,a3�͋��̎��𖞂����܂��B���̔��a��r�Ƃ��Ė߂�l�ɂ��܂��B
% 
% 
% �����F	J,omega,qSize(J��6*3�̍s��),omega��3�s�x�N�g��,qsize��q�̐�Βl
% 
% �߂�F		r,Q(r��a1~a3����鋅�̔��a�AQ��q1~q3����ׂ�����)
% 
%=========================================================

function [r,Q]=qIs(J,omega,qsize,varargin)
Jinv=(pinv(J'))';%���[�A�y�����[�Y�̋^���t�s���Ԃ��܂��B
Q=null(J);
%���̔��a��
temp=qsize'*qsize-(Jinv*omega)'*(Jinv*omega);
r=sqrt(temp);
rnk=rank(Q);
if nargin==4&varargin{1}==1&rnk~=3
    fprintf('qIs:WARNING rank of Jhat is %d instead of 3!----------------------------!!!\n\n',rnk)
end

end