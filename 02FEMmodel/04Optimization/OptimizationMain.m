% ==================================================
% file: OptimizationMain
% detail:
% 設計最適化のためのメインとなるファイルです。
% 
% ==================================================
global node;	global yoso;
global dof;
global K;		global F;
global K0;	global F0;
global delta;
global mat;

[matRatio,matParam]=generateParam(1000);% 引数では何通りのパターンを調べるかを与えます。
[goodRatio,goodParam]=kasousaiki(matRatio,matParam,15*10^-6)