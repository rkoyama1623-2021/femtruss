function [func,L,I,E,A]=whatYoso(a,b)
%�m�[�h�ԍ�����v�f�ԍ���Ԃ��܂��B
%�m�[�ha�ƃm�[�hb���Ȃ��v�f�̔ԍ��́H
%�������Aa<b�Ƃ��܂��B
global yoso;global node;
if a>=b
disp('Error! First var should be less than second one!')
end
temp=0;
	for i=1:length(yoso(1,:))%yoso�s��P�s�ڂ����Ɍ��Ă����܂��B
         if yoso(1,i)==a%1�s�ڂ���m�[�h�ԍ�a��T���B
         	if yoso(2,i)==b%2�s�ڂɃm�[�h�ԍ�b������΁A���̗�ԍ���o�^���āA�T���I���B
				temp=i;break;
          	end
         end
	end
 if temp==0
	disp('error! I cannot find the yoso you are searching!');
 else
	func=temp;
	L=yoso(3,temp);
 	I=yoso(4,temp);
 	E=yoso(5,temp);
 	A=yoso(6,temp);
 end
end
