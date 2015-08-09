function graph3sd(pb,sb,bb)
% ====================
% graph3dPlatform:プラットフォームの形状を描画
% syntax:graph3dPlatform(pb,sb,bb)
% ===================

    %プラットフォームの接続リンクとpベクトルを3次元にプロット
	%プレート上リンクのx,y,z座標をベクトルに格納
    sbx=[sb(1,:) sb(1,1)];
    sby=[sb(2,:) sb(2,1)];
    sbz=[sb(3,:) sb(3,1)];
    
	%ベース上リンクの1x,y,z座標をベクトルに格納
    bbx=[bb(1,:) bb(1,1)];
    bby=[bb(2,:) bb(2,1)];
    bbz=[bb(3,:) bb(3,1)];
    
	%グラフ描画
    plot3([sbx;bbx],[sby;bby],[sbz;bbz],'k',...%足の描画(sbx(1)とbbx(1)を結ぶ->sbx(2)とbbx(2)を結ぶ…)
    sbx,sby,sbz,'g--',...%プレートを結ぶ
    bbx,bby,bbz,'r--',...%ベースを結ぶ
    [0 pb(1)],[0 pb(2)],[0 pb(3)],'b--+')%ベース原点とプレート原点を結ぶ
    
    %グラフのオプション
    %axis square%グラフを正方形にします
    axis equal;%グラフ軸のスケールを1:1:1に
    title('接続リンクの位置関係','fontsize',20); 
    xlabel('x[m]','fontsize',11);
    ylabel('y[m]','fontsize',11);
    zlabel('z[m]','fontsize',11);
    view(3);
    %view(90,0); 
    %view(0,90);    
    %view(150,30);%x軸が左下方向、ｙ軸が右下方向のもっともスタンダードな視点
end

