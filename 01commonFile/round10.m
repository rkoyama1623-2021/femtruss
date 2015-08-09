function ten=round10(var,varargin)
% 引数に一番近い10^nを返します
% オプションで'lt'または'mt'を与えることで，より小さい/大きい値を返します

input=struct('LessOrLarge',0);
%lessorlarge=0ならless

if nargin>=2
    if strcmp(varargin{1},'mt')
        input.LessOrLarge=1;
    end
end


if var>0
    n_dbl=log10(var);
    if input.LessOrLarge==0
        n=floor(n_dbl);
    else
        n=ceil(n_dbl);
    end

    ten=10^n;
elseif var<0
    n_dbl=log10(-var);
    if input.LessOrLarge==0
        n=ceil(n_dbl);
    else
        n=floor(n_dbl);
    end

    ten=-10^n;
else
    ten=0
end

end