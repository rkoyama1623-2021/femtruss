function graph3sd(pb,sb,bb)
% ====================
% graph3dPlatform:�v���b�g�t�H�[���̌`���`��
% syntax:graph3dPlatform(pb,sb,bb)
% ===================

    %�v���b�g�t�H�[���̐ڑ������N��p�x�N�g����3�����Ƀv���b�g
	%�v���[�g�ナ���N��x,y,z���W���x�N�g���Ɋi�[
    sbx=[sb(1,:) sb(1,1)];
    sby=[sb(2,:) sb(2,1)];
    sbz=[sb(3,:) sb(3,1)];
    
	%�x�[�X�ナ���N��1x,y,z���W���x�N�g���Ɋi�[
    bbx=[bb(1,:) bb(1,1)];
    bby=[bb(2,:) bb(2,1)];
    bbz=[bb(3,:) bb(3,1)];
    
	%�O���t�`��
    plot3([sbx;bbx],[sby;bby],[sbz;bbz],'k',...%���̕`��(sbx(1)��bbx(1)������->sbx(2)��bbx(2)�����ԁc)
    sbx,sby,sbz,'g--',...%�v���[�g������
    bbx,bby,bbz,'r--',...%�x�[�X������
    [0 pb(1)],[0 pb(2)],[0 pb(3)],'b--+')%�x�[�X���_�ƃv���[�g���_������
    
    %�O���t�̃I�v�V����
    %axis square%�O���t�𐳕��`�ɂ��܂�
    axis equal;%�O���t���̃X�P�[����1:1:1��
    title('�ڑ������N�̈ʒu�֌W','fontsize',20); 
    xlabel('x[m]','fontsize',11);
    ylabel('y[m]','fontsize',11);
    zlabel('z[m]','fontsize',11);
    view(3);
    %view(90,0); 
    %view(0,90);    
    %view(150,30);%x�������������A�������E�������̂����Ƃ��X�^���_�[�h�Ȏ��_
end

