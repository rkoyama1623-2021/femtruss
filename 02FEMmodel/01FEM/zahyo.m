function Rout=zahyo(i,j)
%syntax: R=zahyo(i,j) 
% 
% �m�[�hi->j�̌����ŁA�������Ƃ�܂��B
% (ui yi zi ph th ps)Global��R��������ƁA(ui yi zi ph th ps)Local
% r'=R*r�̊֌W�����藧���܂��B(r'�͋Ǐ����W)
% R��12�~12�̍s��ł�
global node;
dx=node(1,j)-node(1,i);
dy=node(2,j)-node(2,i);
dz=node(3,j)-node(3,i);

r=[dx;dy;dz];

%�p�x�����߂܂��B
%�p�x�́A���̎�������]�Ɋւ���Ώې��ɒ��ӂ��āA
%global���W��local���W�Ɉڂ��ے������̂悤�ɍl���܂��B
%z�������th��]->�V�������W�n��y�������ph��]

%��	��z������̉�]�p�����߂܂��B
th=whatAngle(dx,dy);

%z�������th�񂵂��ꍇ�ɐV�������W�n�Ō����A���W�́A
Rz=...
[cos(th) sin(th) 0;...
 -sin(th) cos(th) 0;...
       0       0  1];%z������̉�]�ł̍��W�ϊ��s�񂪓���ꂽ�B

r=Rz*r;
dx=r(1);
	%dy2=r2(2);%���K��0�ɂȂ�̂ŋ��߂Ȃ�
dz=r(3);

%����y������̉�]�p�����߂܂��B
ph=whatAngle(dx,dz);

Ry=...
[cos(ph) 0 sin(ph);...
0 1 0;...
-sin(ph) 0 cos(ph)];%y������̉�]�ł̍��W�ϊ��s�񂪓���ꂽ�B

%���W�ϊ��s������߂܂��B
R1=Ry*Rz;%Global�Ō���ui,yi,zi��local�Ō���ui,yi,zi�ɕϊ�����s��

%��̃m�[�h�̎���6�̕ϐ���Local����Global�ɕϊ�����s��B
R2=zeros(6,6);
R2(1:3,1:3)=R1;
R2(4:6,4:6)=R1;

%��̃m�[�h����Ȃ�12�s�x�N�g����Global���W�ɕϊ�����s��
R=zeros(12,12);
R(1:6,1:6)=R2;
R(7:12,7:12)=R2;

Rout=R;
end


function th=whatAngle(dx,dy)
    if dx>0
    	th=atan(dy/dx);
    elseif dx==0
        if dy>0
        	th=pi/2;
        elseif dy<0
        	th=-pi/2;
        else
        	th=0;
    	end
    else
    	th=atan(dy/dx)+pi;
    end
end