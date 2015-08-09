function func=plateCenter(varargin)
% ========================================================================
% file name:plateCenter
% detail:�����ɉ����āA�v���[�g�̕ψʂ�v���[�g�̃m�[�h�̕ψʂ�Ԃ��܂��B
% syntax:
% plateCenter     �v���[�g���S�̕ψʂ�Ԃ��܂�
% plateCenter('p')     �v���[�g��6���_�̕ψʂ��x�N�g���Ƃ���s���Ԃ��܂��B
% plateCenter(a:b)      �v���[�g�̕ψʂ�a~b������\��
% ========================================================================

delta0=zeros(6,6);
switch nargin
    case 0  %�����Ȃ�
        func=displacement(0);
    case 1  %�������聨�����̉��
        if varargin{1}=='p' %�o�̓����N�̕ψʂ��x�N�g���Ƃ����s��ŕԂ��܂�
            for i=1:6
                delta0(:,i)=displacement(i);
            end
            func=delta0;
        end
        if size(varargin{1},2)~=1   %�������x�N�g���ŗ^����ꂽ�ꍇ�A�v���[�g���S�̕ψʂ̊Y�����鐬����Ԃ��܂�
            temp=displacement(0);
            func=temp(varargin{1});            
        end
end

end