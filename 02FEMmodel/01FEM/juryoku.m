function juryoku(i)

global yoso; global node;
global F;

%�v�fi�ɏd�͂�������B

%��������fg�̘g������Ă����܂��B
fgmoto=zeros(6*length(node(1,:)),1);

%�d�͉����x
g=1;

%�v�f���Ƃɏd�͂̉׏d�x�N�g�����쐬���A�S�̂֊g�債�܂��B

nodei=yoso(1,i);%�v�f���\������m�[�h�ԍ�
nodej=yoso(2,i);
L=yoso(3,i);%�v�fi�̒���L
A=yoso(4,i);%�v�fi�̖ʐς��擾
rho=yoso(10,i);%�v�fi�̖��x���擾

%N3�̐ϕ��������̂�maxima�ł��炩���ߋ��߂Ă������B
N3t=...
[L/2,0,0;... 
0,L/2,0;... 
0,0,L/2;... 
0,0,0;... 
0,0,-L^2/12;... 
0,L^2/12,0;... 
L/2,0,0;... 
0,L/2,0;... 
0,0,L/2;... 
0,0,0;... 
0,0,L^2/12;... 
0,-L^2/12,0] ;

%���W�ϊ��s������߂܂��B
R=zahyo(nodei,nodej);%12�ϐ���global���W->Local���W�֕ϊ�
R2=R(1:3,1:3);%�͂̂R�ϐ��݂̂̕ϊ�
fgtemp=R'*N3t*R2*(rho*g*A.*[0;0;-1]);

%�n�S�̂ɍ��킹�Ċg�債�܂��B
fgi=fgtemp(1:6);
fgj=fgtemp(7:12);

fg=zeros(6*length(node(1,:)),1);
fg(1+6*(nodei-1):6*nodei)=fgi;
fg(1+6*(nodej-1):6*nodej)=fgj;

fgmoto=fg+fgmoto;

F=F+fg;

end