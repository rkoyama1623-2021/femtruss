function dL=nobi(yosoi)
% ========================================================================
% file name:nobi
% detail:�v�fi�̐L�т�Ԃ��܂��B
% syntax:
% dL=extention(i)    i�Ԗڂ̗v�f�̐L�т�dL�ɓn���܂��B[m]
% ========================================================================

global yoso;
global nobi;

dij=displacement(yosoi,'local');

% x�����ψʂ��擾
ui=dij(1);
uj=dij(7);

% x�����ψʂ̍����L�т����߂�
dL=uj-ui;

end