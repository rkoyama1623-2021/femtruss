function [func,L,I,E,A]=whatYoso(a,b)
%ノード番号から要素番号を返します。
%ノードaとノードbをつなぐ要素の番号は？
%ただし、a<bとします。
global yoso;global node;
if a>=b
disp('Error! First var should be less than second one!')
end
temp=0;
	for i=1:length(yoso(1,:))%yoso行列１行目を順に見ていきます。
         if yoso(1,i)==a%1行目からノード番号aを探す。
         	if yoso(2,i)==b%2行目にノード番号bがあれば、その列番号を登録して、探索終了。
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
