function qnew =  crt_qrand(xstart, xgoal, cmax)
xstart = xstart';
xgoal = xgoal';
cmin=norm(xgoal-xstart);
xcenter=(xgoal+xstart)/2;
theta = atan2(xgoal(2)-xstart(2), xgoal(1)-xstart(1));
C=[cos(theta) -sin(theta); sin(theta) cos(theta)];
L=[cmax/2 0; 0 sqrt(cmax^2-cmin^2)/2];
a = rand * 2 * pi;
r = sqrt(rand);
xball =[ r * cos(a); r * sin(a)];
xrand = C*L*xball+xcenter;
qnew= xrand';
 end