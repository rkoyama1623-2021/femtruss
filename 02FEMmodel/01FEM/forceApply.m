function Fout=forceApply(i,Fx,Fy,Fz,Mx,My,Mz)
	global dof;global node;
	global F;

if i>length(node(1,:))
	fprintf('Error(forceApply):the node you choose does not exist!\n\n\n');
	return
end
	F(1+dof*(i-1):dof*i)=F(1+dof*(i-1):dof*i)+[Fx,Fy,Fz,Mx,My,Mz]';
	Fout=F;
end
