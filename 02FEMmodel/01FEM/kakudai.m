function Kgbig=kakudai(Kg,a)
%a�ԗv�f�̂΂˒萔���g�債�܂��B
% �g���̍s��̑傫����lenMat�ŗ^���܂��B

    global yoso;
    global node;
	global dof;
    
	%�v�fa���\������m�[�h�����߂܂��B
	i=yoso(1,a);
	j=yoso(2,a);
	n=dof*length(node(1,:));
	Kgbig=kakudai2(Kg,i,j,n);

end