function plane=inPlane(v3)
% ¬•ª‚ª‚ ‚é‚Æ1
zero=10^-6;
plane=ones(1,3);

v3n=norm(v3);
v3p=abs(v3./v3n);
if v3p(1)<zero
    plane(1)=0;
elseif v3p(2)<zero
    plane(2)=0;
elseif v3p(3)<zero
    plane(3)=0;
end

end