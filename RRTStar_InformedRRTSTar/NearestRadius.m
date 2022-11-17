function [RRTx_r] = RRTx_radius(G, stepsize,A)
% plot (A)
xLimits = 140; %get(gca,'XLim');  
yLimits = 140; %get(gca,'YLim'); 
% close gcf
d = 5;
A_circle = pi*1^2;
A_poly = area(A);
% A_graph = diff(xLimits)*diff(yLimits);
A_graph = xLimits*yLimits;
A_total = A_graph - A_poly;
gRRTx= 2*(1+(1/d))^(1/d)*(A_total/A_circle)^(1/d);
RRTx_rad = gRRTx*(log(G.n)/G.n)^(1/d);
RRTx_r = min([RRTx_rad, stepsize]);
% RRTx_r = RRTx_rad-5;
end

