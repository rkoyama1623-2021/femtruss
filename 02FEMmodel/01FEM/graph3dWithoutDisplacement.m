function graph3dWithoutDisplacement(bairitu)
global node;global yoso;
global delta;
%計算結果をグラフにします
%変位を見やすくするために、bairitu倍して変位を表示します。

disp('-----------------------------------------')
disp('Draw Graph')
disp('-----------------------------------------')


N=10;%プロット間隔（一つの梁をN等分します）

%最初の梁の位置をプロット

hold on%各要素を順に描画して重ね合わせていきます。

fprintf('drawing yoso...')
for i=1:length(yoso(1,:));%i番要素の描画
    fprintf('%d ',i)
    
    %ノード座標を取得
    nodei=yoso(1,i);
    nodej=yoso(2,i);
    
    plot3(...
     	[node(1,nodei) node(1,nodej)],...
     	[node(2,nodei) node(2,nodej)],...
    	[node(3,nodei) node(3,nodej)],'k--')%ノードをつなぐ
end

plot3(node(1,:),node(2,:),node(3,:),'ks')%ノードの最初の位置にプロット

%legend('before','after');
axis equal;
%axis([0 1 0 1 0 1])
view(3);

hold off;
xlabel('x[m]','fontsize',11);
ylabel('y[m]','fontsize',11);
zlabel('z[m]','fontsize',11);


%x=0:L/10:L;
%y=zeros(1,length(x))
%u=dx
%v=dy
%figure
%quiver(x,y,u,v)

disp('Graph has drawn.')
end





