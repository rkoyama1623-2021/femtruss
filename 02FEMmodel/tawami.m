function func_v=tawami(yosoi)
% ====
% tawami
%     syntax:tawamim(yoso_i)
%     yoso_i�Ԃ̗v�f�̂���݂��v�Z���܂��B
%     ���[�J�����W�Ŏ��Ɛ��������̕ψʂ��A����̃m�[�h���猩�܂��B
% ====

global yoso

% �v�f�̒������擾
L=yoso(3,yosoi);

% �v�f���\������m�[�h��Local�ψʂ��擾
dij=displacement(yosoi,'local');

% y,z�����ψʂ��擾
yi=dij(2);
yj=dij(8);

zi=dij(3);
zj=dij(9);

% yz������̉�]�ʂ��擾
thi=dij(5);
psi=dij(6);
thj=dij(11);
psj=dij(12);
% �m�[�hi�̕ψʂƊp�x��p���āA���̂���݂��Ȃ��ꍇ�̃m�[�hj�̕ψʂ����߂܂�
yj2=yi+L*psi;
zj2=zi-L*thi;

yi2=yj-L*psj;
zi2=zj+L*thj;
% ���Ɛ��������̂���݂����߂܂��B
func_v=min(norm([yj-yj2,zj-zj2]),...
                    norm([yi-yi2,zi-zi2]));

end