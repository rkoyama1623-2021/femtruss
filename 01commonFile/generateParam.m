% ============================================
% file name:generateParam
% detail:
% 最適化設計をするために、設計パラメータを乱数的に生成します。
% 
% input:nParam(発生させるパラメータの個数)
% output:matRatio,matParam(0~1のパラメータ、列ベクトルを設計パラメータとする行列を生成します)
% matParamは設計パラメータを格納した行列で、以下の順にパラメーターが入っています。
% p,br,thb,sr,thp,   /  alpha,r
% 
%flag=1のとき有限要素モデル用になる 
% ============================================

function [matRatio,matParam]=generateParam(nParam,flag)
% 設計パラメータの最大値を与えます。
% 静定・不静定で共通のパラメーター
pMin=0;
pMax=0.3;
brMin=0.05;
brMax=0.6;
thbMin=0;
thbMax=pi/3;
srRatioMin=0.5;
thpMin=0;
thpMax=pi/3;


% 以下の共通部分は後で直す
if flag==1
% 有限要素モデル特有のパラメーター
alphaMin=0;
alphaMax=0.1;
rMin=0;%弾性ヒンジの半径
rMax=0.015/2;%弾性ヒンジの半径

matRatio=rand(7,nParam);

paramMax=[pMax,brMax,thbMax,1,thpMax,alphaMax,rMax]';
paramMin=[pMin,brMin,thbMin,srRatioMin,thpMin,alphaMin,rMin]';

temp=(paramMax-paramMin)*ones(1,nParam);
matParam2=matRatio.*temp+paramMin*ones(1,nParam);
matParam2(4,:)=matParam2(2,:).*matRatio(4,:);
matParam=matParam2;

else

matRatio=rand(5,nParam);

temp=([pMax,brMax,thbMax,1,thpMax]'-[pMin,brMin,thbMin,srRatioMin,thpMin]')*ones(1,nParam);
matParam2=matRatio.*temp+[pMin,brMin,thpMin,srRatioMin,thpMin]'*ones(1,nParam);
matParam2(4,:)=matParam2(2,:).*matParam2(4,:);%srを決定
matParam=matParam2;

end




end
