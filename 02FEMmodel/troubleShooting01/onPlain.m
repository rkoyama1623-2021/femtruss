function func=onPlain()
global delta

for i=1:6
delta0(:,i)=displacement(i);
end
disp('angle differences')
eps=(delta0-delta0(:,1)*ones(1,6))./(delta0(:,1)*ones(1,6));
func=max(max(eps(4:6,:)))
end
