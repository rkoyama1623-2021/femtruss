function [sr,thp,br,thb,pb,r,alpha]=loadParam(matParam)
% �p�����[�^�[���s�񂩂�ǂ݂������܂�


% ====================== �p�����[�^�[�̐ݒ�ǂݍ��� ==========================
pz=matParam(1);
pb=[0,0,pz]';

br=matParam(2);
thb=matParam(3);
sr=matParam(4);
thp=matParam(5);

if size(matParam,1)>5
	alpha=matParam(6);
	r=matParam(7);
end

end