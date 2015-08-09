function ten=round10(var,varargin)
% �����Ɉ�ԋ߂�10^n��Ԃ��܂�
% �I�v�V������'lt'�܂���'mt'��^���邱�ƂŁC��菬����/�傫���l��Ԃ��܂�

input=struct('LessOrLarge',0);
%lessorlarge=0�Ȃ�less

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