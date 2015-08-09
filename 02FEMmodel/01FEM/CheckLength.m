function CheckLength(str)
%�m�[�h�̍��W�Ɨv�f�̒����p�����[�^�̒l�ɕs�������Ȃ����m�F����B�s�������������ꍇ�ɂ́Astr�ɏ]���đ���B
%str��'node'�Ȃ�node�D��ŗv�f��L������������B'yoso'�Ȃ�G���[���o���āA�m�[�h��ҏW���Ȃ����B

global yoso;global node;

for i=1:length(yoso(1,:))%�v�f���P���珇�Ƀ`�F�b�N

	L=yoso(3,i);
	
	nodei=yoso(1,i);
	nodej=yoso(2,i);
	
	xi=node(1,nodei);
	yi=node(2,nodei);
	zi=node(3,nodei);
	xj=node(1,nodej);
	yj=node(2,nodej);
	zj=node(3,nodej);

	kyori=sqrt((xi-xj)^2+(yi-yj)^2+(zi-zj)^2);
	
 if abs(kyori-L)>0.001*L
	    if str=='node'
			yoso(3,i)=kyori;
%			sprintf('the value of L in yoso %d was corrected!\n',i)
     	else
			yoso=0;
%			disp('Error!!! L in yoso differs from the distance between nodes')
    	end
 	end

end