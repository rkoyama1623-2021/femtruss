function [flag,eps]=isSame(a,b,varargin)
% ===
% isSame
% 二つの数またはベクトルが等しいか判定します。
% syntax: [flag,eps]=isSame(a,b,opt_epsMax)
% aを基準としたbの相対誤差を評価します。
% 相対誤差がopt_epsMax以下のとき、二つの数は同じであると判定します。
% opt_epsMaxが明示的に与えられないとき、opt_epsMaxはe-6です。
% ===
    if nargin==2
        ratio_max=10^-6;
    else
        ratio_max=varargin{1}
    end
    
    eps=norm(b-a)./norm(a);
    if eps<ratio_max
        flag=1;
    else
        flag=0;
    end
end