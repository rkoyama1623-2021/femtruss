function ellipsoid2d(vector,varargin)

th=0:pi/40:2*pi;
X=vector(1)*cos(th);
Y=vector(2)*sin(th);
if nargin>1
    plot(X,Y,varargin{1})
else
    plot(X,Y)
end
axis 'equal'

end