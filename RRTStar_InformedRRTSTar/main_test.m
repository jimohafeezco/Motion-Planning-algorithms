close all;
clear, clc
[polyObs, Obstacles]=LoadObstacles;
% plot(polyObs);
hold on
qgoal=[90,80];
qstart=[10,20];
% qstart = ginput(1); 
plot(qstart(1),qstart(2), 'Marker', 'd', 'MarkerFaceColor', 'b','MarkerEdgeColor', 'k' , 'LineWidth', 3);
% % qgoal = ginput(1);
plot(qgoal(1),qgoal(2), 'Marker', 'd', 'MarkerFaceColor', 'b','MarkerEdgeColor', 'k' , 'LineWidth', 3);
N=5000;
stepsize =10;
tic
[Path,G]=RRT(Obstacles,polyObs,qstart, qgoal,  stepsize, N);
toc
saveas(gcf,'RRT5000','epsc')