function graph3dWithoutDisplacement(bairitu)
global node;global yoso;
global delta;
%�v�Z���ʂ��O���t�ɂ��܂�
%�ψʂ����₷�����邽�߂ɁAbairitu�{���ĕψʂ�\�����܂��B

disp('-----------------------------------------')
disp('Draw Graph')
disp('-----------------------------------------')


N=10;%�v���b�g�Ԋu�i��̗���N�������܂��j

%�ŏ��̗��̈ʒu���v���b�g

hold on%�e�v�f�����ɕ`�悵�ďd�ˍ��킹�Ă����܂��B

fprintf('drawing yoso...')
for i=1:length(yoso(1,:));%i�ԗv�f�̕`��
    fprintf('%d ',i)
    
    %�m�[�h���W���擾
    nodei=yoso(1,i);
    nodej=yoso(2,i);
    
    plot3(...
     	[node(1,nodei) node(1,nodej)],...
     	[node(2,nodei) node(2,nodej)],...
    	[node(3,nodei) node(3,nodej)],'k--')%�m�[�h���Ȃ�
end

plot3(node(1,:),node(2,:),node(3,:),'ks')%�m�[�h�̍ŏ��̈ʒu�Ƀv���b�g

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





