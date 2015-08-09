function func_vector=genVect(var_min,interbal,var_max,rpt1,rpt2)
% ===
% genVect
%     syntax:vector=genVect(var_min,interbal,var_max,rept1,rpt2)
%     rpt1回ずつ繰り返しながら増加するベクトルをrpt2回並べたベクトルを返します
%     ex:genVect(3,1,5,2,4)
%         out:[3 3 4 4 5 5]を4回並べたもの
% ===

% interbalが半端だった時の処理
n=ceil((var_max-var_min)/interbal);
int=(var_max-var_min)/n;%間隔
nVect1=(n+1)*rpt1;%成分の数
nVect2=nVect1*rpt2;%出力ベクトルの成分の数

vect1=var_min*ones(1,nVect1);
vect2=zeros(1,nVect2);

for i=1:n
    vect1(1+rpt1*i:nVect1)=vect1(1+rpt1*i:nVect1)+int;
end

for i=0:rpt2-1
    vect2(1+nVect1*i:nVect1*(i+1))=vect1;
end

func_vector=vect2;


end
