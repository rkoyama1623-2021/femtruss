function dL=nobi(yosoi)
% ========================================================================
% file name:nobi
% detail:—v‘fi‚ÌL‚Ñ‚ğ•Ô‚µ‚Ü‚·B
% syntax:
% dL=extention(i)    i”Ô–Ú‚Ì—v‘f‚ÌL‚Ñ‚ğdL‚É“n‚µ‚Ü‚·B[m]
% ========================================================================

global yoso;
global nobi;

dij=displacement(yosoi,'local');

% x•ûŒü•ÏˆÊ‚ğæ“¾
ui=dij(1);
uj=dij(7);

% x•ûŒü•ÏˆÊ‚Ì·L‚Ñ‚ğ‹‚ß‚é
dL=uj-ui;

end