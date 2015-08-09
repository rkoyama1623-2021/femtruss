function graph3dPlatform(bairitu)
% ====
% 計算誤差がプラットフォームの変形に拡大されて現れないよう
% プラットフォームだけ直線描画
% ====
graph3d(bairitu,'y',1:18)%足の描画
graph3d(bairitu,'y',19:24,'w2')
graph3d(bairitu,'y',25:30)%ベースの描画


end