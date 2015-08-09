% 行列を受け取った時、その行列が対角行列かどうか判定します


function [func b]=isDiag(A)
	len=length(A(1,:));
    a=max(diag(A));
    Aprop=A./a;
    
    for i=1:len
	  Aprop(i,i)=0;
    end
        
    b=max(max(abs(Aprop)));
    if b<10^-5
		func=1;
    else
		func=0;
    end

end