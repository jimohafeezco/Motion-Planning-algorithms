close all;
clear, clc
[polyObs, Obstacles]=LoadObstacles;
% plot(polyObs);
hold on
% qgoal=[90,80];
% qstart=[10,20];
qstart = ginput(1); 
plot(qstart(1),qstart(2), 'Marker', 'd', 'MarkerFaceColor', 'b','MarkerEdgeColor', 'k' , 'LineWidth', 3);
qgoal = ginput(1);
plot(qgoal(1),qgoal(2), 'Marker', 'd', 'MarkerFaceColor', 'b','MarkerEdgeColor', 'k' , 'LineWidth', 3);
N=200;
stepsize = 15;
tic;
[G,cost_rrtstar]=RRTStar(qstart,qgoal,polyObs,N,stepsize);
toc;
saveas(gcf,'RRTStar','epsc')


figure()
[polyObs, Obstacles]=LoadObstacles;
plot(qstart(1),qstart(2), 'Marker', 'd', 'MarkerFaceColor', 'b','MarkerEdgeColor', 'k' , 'LineWidth', 3);
plot(qgoal(1),qgoal(2), 'Marker', 'd', 'MarkerFaceColor', 'b','MarkerEdgeColor', 'k' , 'LineWidth', 3);
tic;
[G2,cost_rrtinformed]=RRTx_Informed(qstart,qgoal,polyObs,N,stepsize);
toc;
saveas(gcf,'RRTStarInformed','epsc')

figure()
[polyObs, Obstacles]=LoadObstacles;
plot(qstart(1),qstart(2), 'Marker', 'd', 'MarkerFaceColor', 'b','MarkerEdgeColor', 'k' , 'LineWidth', 3);
plot(qgoal(1),qgoal(2), 'Marker', 'd', 'MarkerFaceColor', 'b','MarkerEdgeColor', 'k' , 'LineWidth', 3);
hold on;
r=10;
tic
step=0.1;
[G3,cost_sprm] =SPRM(Obstacles,qstart, qgoal, N, r, step);
toc
saveas(gcf,'SPRM','epsc')




figure()
N=200;stepsize=10;
[polyObs, Obstacles]=LoadObstacles;
plot(qstart(1),qstart(2), 'Marker', 'd', 'MarkerFaceColor', 'b','MarkerEdgeColor', 'k' , 'LineWidth', 3);
% qgoal = ginput(1);
plot(qgoal(1),qgoal(2), 'Marker', 'd', 'MarkerFaceColor', 'b','MarkerEdgeColor', 'k' , 'LineWidth', 3);

tic
[G4,cost_rrt]=RRT(Obstacles,polyObs,qstart, qgoal,  stepsize, N);
toc
saveas(gcf,'RRT1000','epsc')

