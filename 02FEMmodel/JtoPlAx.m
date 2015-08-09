function [plAx,V]=JtoPlAx(mat,option,varargin)
% ====
% JtoPlAx
%     [plAx,V]=JtoPlAx(J,option,opt_flag)
%         option:'p1','p2','p3','w1','w2'
%         p:•ÀiˆÚ“®‚Ì‰Â‘€ì‘È‰~‘Ì[m]
%         w:‰ñ“]‚Ì‰Â‘€ì‘È‰~‘Ì["](ƒOƒ‰ƒt‚Íƒ‰ƒWƒAƒ“)
%         1:p¨‚Ü‚½‚ÍˆÊ’u‚ÌS‘©‚È‚µ
%         2:p¨‚Ü‚½‚ÍˆÊ’u‚ÌS‘©‚ ‚è
%         p3:z²ü‚è‚Ì‰ñ“]‚Ì‚İ‹–—e‚·‚é•ÀiˆÚ“®
% 
%     ƒ„ƒRƒrs—ñ‚©‚ç‰Â‘€ì‘È‰~‘Ì‚Ìå²‚ğ‹‚ß‚é
%     flag='g'‚Ì‚Æ‚«ƒOƒ‰ƒt•`‰æ
% ====



flag=0;

if nargin>2&strcmp(varargin{1},'g')
    flag=1;
end

%ƒ„ƒRƒrs—ñ‚Ì•ªŠ„(•Ài‚Æ‰ñ“])
J1=mat(1:3,:);
J2=mat(4:6,:);

if strcmp(option,'p1')==1
    J1inv=pinv(J1')';%pinv‚Íc’·s—ñ‚É‚µ‚©“K—p‚Å‚«‚È‚¢‚½‚ßA“]’u‚Ì‹^—‹ts—ñ‚ğ‹‚ß‚Ä‚©‚ç“]’u‚µ‚Ä‚¢‚éB(freeMat)
    A=J1inv'*J1inv;
    [V,D,plAx]=drawEllipsoid(A,[],flag);
end
if strcmp(option,'p2')==1
    omega=[0 0 0]';
    qsize=1;
    [r,Q]=qIs(J2,omega,qsize);

    J2inv=pinv(J2')';
    tempJ=J1*Q;
    
    tempJinv=pinv(tempJ')';
    A=tempJinv'*tempJinv;
    r0=J1*J2inv*omega;
    [V,D,plAx]=drawEllipsoid(A,r0,flag);
end
if strcmp(option,'p3')==1
    omega=[0 0]';
    qsize=1;
    [r,Q]=qIs(mat(4:5,:),omega,qsize);

    tempJ=J1*Q;
    
    tempJinv=pinv(tempJ')';
    A=tempJinv'*tempJinv;
    [V,D,plAx]=drawEllipsoid(A,0,flag);
end

if strcmp(option,'w1')==1
    J2inv=pinv(J2')';%pinv‚Íc’·s—ñ‚É‚µ‚©“K—p‚Å‚«‚È‚¢‚½‚ßA“]’u‚Ì‹^—‹ts—ñ‚ğ‹‚ß‚Ä‚©‚ç“]’u‚µ‚Ä‚¢‚éB(freeMat)
    A=J2inv'*J2inv;
    [V,D,plAx]=drawEllipsoid(A,[],flag);
    
    % rad->•bŠp•ÏŠ·
    plAx=plAx.*180/pi*3600;
    
end
if strcmp(option,'w2')==1
    omega=[0 0 0]';
    qsize=1;
    [r,Q]=qIs(J1,omega,qsize);

    J1inv=pinv(J1')';
    tempJ=J2*Q;
    
    tempJinv=pinv(tempJ')';
    A=tempJinv'*tempJinv;
    r0=J1*J1inv*omega;
    [V,D,plAx]=drawEllipsoid(A,r0,flag);
    
    % rad->•bŠp•ÏŠ·
    plAx=plAx.*180/pi*3600;
end


end