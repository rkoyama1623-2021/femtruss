function Kg=bane(i)
%�v�f�ԍ���^����ƁA���̂΂ˍs��(global���W)��Ԃ��܂�
global yoso;

Klocal=bane2(i);


%���W�ϊ��̍s��𐶐����܂��B
R=zahyo(yoso(1,i),yoso(2,i));

%global���W�ł̂΂˒萔�s��

Kg=R'*Klocal*R;

% sprintf('K of Yoso(%d) was created!\n',i)


end
