% ==================================================
% file: OptimizationMain
% detail:
% �݌v�œK���̂��߂̃��C���ƂȂ�t�@�C���ł��B
% 
% ==================================================
global node;	global yoso;
global dof;
global K;		global F;
global K0;	global F0;
global delta;
global mat;

[matRatio,matParam]=generateParam(1000);% �����ł͉��ʂ�̃p�^�[���𒲂ׂ邩��^���܂��B
[goodRatio,goodParam]=kasousaiki(matRatio,matParam,15*10^-6)