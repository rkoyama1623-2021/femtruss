function [flag,eps]=isSame(a,b,varargin)
% ===
% isSame
% ��̐��܂��̓x�N�g���������������肵�܂��B
% syntax: [flag,eps]=isSame(a,b,opt_epsMax)
% a����Ƃ���b�̑��Ό덷��]�����܂��B
% ���Ό덷��opt_epsMax�ȉ��̂Ƃ��A��̐��͓����ł���Ɣ��肵�܂��B
% opt_epsMax�������I�ɗ^�����Ȃ��Ƃ��Aopt_epsMax��e-6�ł��B
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