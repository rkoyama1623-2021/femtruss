function maesyori()


global node;	global yoso;
global dof;
global K;		global F;
global K0;
global heatedYoso
dof=6;	%��̐ړ_�������R�x�ł��B����͕��iuv�Ɗp�xth�̂R���R�x


%yoso=zeros(8,nYoso);	%�v�f�̏W���Bi��ڂ̐����́Ai�ԗv�f�����p�����[�^�ŁA�P�ڂ̃m�[�h�̔ԍ��A�Q�ڂ̃m�[�h�ԍ��AL�AE,G�AI�AIp,A�A���c���W��,���x�ł��B
%node=zeros(3,nNode);%�m�[�h�̈ʒu�B��ԍ����m�[�h�̔ԍ��ł��B��x�N�g���̐����́A�m�[�h�����W�A�m�[�hy���W,�m�[�hz���W



%---------------------------
%
%�v�f�̐ݒ肪�������Ƃ���
%
%---------------------------

%���M�v�f�Ɖ��M���x���L������s��
heatedYoso=zeros(2,1);


% printf('Node is\n')
% disp(node)
nNode=length(node(1,:));
% printf('yoso is\n')
% disp(yoso)
nYoso=length(yoso(1,:));



%%%%%%%%%%%%% �΂˒萔�s����쐬 %%%%%%%%%%
%�v�f1���珇�ɂ΂˒萔(global)�����߁A�g�債�A�d�ˍ��킹�܂��B

K=zeros(dof*nNode,dof*nNode);
for i=1:nYoso
	Kg=bane(i);
	KgBig=kakudai(Kg,i);
	K=K+KgBig;
end
K0=K;%���E�����ɍ��킹��K��ό`����O�̏�Ԃ�ۑ�
%printf('K is\n')
%disp(K)

%%%%%%%%%%%% �׏d�����̑O���� %%%%%%%%%%%%%%%%
F=zeros(dof*nNode,1);

%---------------------------------------------------------------------------------------

end
