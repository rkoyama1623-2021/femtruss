function func=plateCenter(varargin)
% ========================================================================
% file name:plateCenter
% detail:引数に応じて、プレートの変位やプレートのノードの変位を返します。
% syntax:
% plateCenter     プレート中心の変位を返します
% plateCenter('p')     プレートの6頂点の変位を列ベクトルとする行列を返します。
% plateCenter(a:b)      プレートの変位のa~b成分を表示
% ========================================================================

delta0=zeros(6,6);
switch nargin
    case 0  %引数なし
        func=displacement(0);
    case 1  %引数あり→引数の解析
        if varargin{1}=='p' %出力リンクの変位を列ベクトルとした行列で返します
            for i=1:6
                delta0(:,i)=displacement(i);
            end
            func=delta0;
        end
        if size(varargin{1},2)~=1   %引数がベクトルで与えられた場合、プレート中心の変位の該当する成分を返します
            temp=displacement(0);
            func=temp(varargin{1});            
        end
end

end