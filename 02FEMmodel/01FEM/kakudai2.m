function Kgbig=kakudai2(Kg,i,j,n)
% ===============================================
% file name:kakudai2
% detail:
% i�ԃm�[�h��j�ԃm�[�h�̊Ԃ̂΂˒萔��
% �S�̂̂΂˒萔�֊g�債�܂��B
% i��j�̏��Ԃɒ��ӂ��Ă��������I
% ===============================================
global node;
global yoso;
global dof;

    %�΂ˍs������s��ɕ���
	Kgii=Kg(1:dof,1:dof);
	Kgij=Kg(1:dof,dof+1:2*dof);
	Kgji=Kg(dof+1:2*dof,1:dof);
	Kgjj=Kg(dof+1:dof*2,dof+1:2*dof);
	
	%�g��s��̘g�����܂�
	Kgbigtemp=zeros(n,n);
	
	Kgbigtemp(1+dof*(i-1):dof*(i),1+dof*(i-1):dof*(i))=Kgii;
	Kgbigtemp(1+dof*(i-1):dof*(i),1+dof*(j-1):dof*(j))=Kgij;
	Kgbigtemp(1+dof*(j-1):dof*(j),1+dof*(i-1):dof*(i))=Kgji;
	Kgbigtemp(1+dof*(j-1):dof*(j),1+dof*(j-1):dof*(j))=Kgjj;
	
	Kgbig=Kgbigtemp;


end