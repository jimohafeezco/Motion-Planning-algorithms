function h = circle(x,y,r)
hold on
th = 0:pi/50:2*pi;
xunit = r*cos(th) + x;
yunit = r*sin(th) + y;
grayColor = [.7 .7 .7];
h = plot(xunit,yunit,'Color', grayColor,'Linewidth', 1,'HandleVisibility','off');
end
