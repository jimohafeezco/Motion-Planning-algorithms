clear all
close all
% Path A
r =1;
% init = [2, 2, -pi/3];
% goal = [6, 6, -pi/6];
figure()
xlim([0, 10])
ylim([0,10])
init= ginput(1); %
goal  = ginput(1); % 
dir1 = rand*2*pi;   % directions are randomly generated between [0 and 2pi for init and goal position]
dir2 = rand*2*pi;
init = [init, dir1];
goal = [goal, dir2];
plot(init(1), init(2), "k*",'MarkerSize',12); hold on;
plot(goal(1), goal(2), "r*",'MarkerSize',12);
hold on;
quiver(init(1), init(2), r*cos(init(3)), r*sin(init(3)),'Linewidth', 2,'HandleVisibility','off');
% legend('')
hold on
quiver(goal(1), goal(2), r*cos(goal(3)), r*sin(goal(3)),'Linewidth', 2,'HandleVisibility','off');
axis equal
% this function generates the 4 dubin circles centres.
[LRcircles] =dubin_circles(init, goal, r);
cLinit=LRcircles(1,:); cLgoal=LRcircles(2,:); cRinit=LRcircles(3,:);cRgoal=LRcircles(4,:);
dubinsCirclePlot(init, goal, LRcircles,r);axis equal
% find LSL path and cost
[CostLSL, pathlsl, ~] = LSL(init, goal, cLinit',cLgoal',r);
subplot(2,2,1);
plot(pathlsl(:,1) , pathlsl(:,2), 'r','Linewidth', 2); title("LSL"); hold on;
dubinsCirclePlot(init, goal, LRcircles,r);
% find LSR cost and path
[CostLSR, pathlsr, ~] = LSR(init, goal,cLinit',cRgoal',r);axis equal
subplot(2,2,2);
plot(pathlsr(:,1) , pathlsr(:,2),'r', 'Linewidth', 2); title("LSR");hold on;
dubinsCirclePlot(init, goal, LRcircles,r);axis equal
% find RSR cost and path
[CostRSR, pathrsr, ~] = RSR(init, goal,cRinit',cRgoal',r);
subplot(2,2,3); 
plot(pathrsr(:,1) , pathrsr(:,2), 'r', 'Linewidth', 2);title("RSR");hold on;
dubinsCirclePlot(init, goal, LRcircles,r);axis equal
% find RSL path and cost
[CostRSL, pathrsl, ~] = RSL(init, goal,cRinit',cLgoal',r);
subplot(2,2,4); 
plot(pathrsl(:,1) , pathrsl(:,2),'r','Linewidth', 2); title("RSL");hold on;
dubinsCirclePlot(init, goal, LRcircles,r)
axis equal
saveas(gcf,'dubin_path','epsc')

% % % Path B
% compare the 4 dubin paths together and output the minimum
[~,path,name]= shortest_path(init, goal,LRcircles,r);
figure()
plot(path(:,1) , path(:,2), 'r', 'Linewidth', 2);hold on;
plot(init(1), init(2), "k*",'MarkerSize',12); hold on;
plot(goal(1), goal(2), "b*",'MarkerSize',12);
text(5,5,name, 'FontSize', 12)
text(init(1), init(2)+0.5,"init", 'FontSize', 8)
text(goal(1), goal(2)+0.5,"goal", 'FontSize', 8)
axis equal
xlim([0, 10])
ylim([0,10])
saveas(gcf,'dubin_path2','epsc')

% Path C
figure()
[~, Obstacles] = LoadObstacles;
qstart= ginput(1); %
qgoal= ginput(1); % 
text(qstart(1), qstart(2) +0.2, '$q_{start}$','Interpreter', 'latex', 'FontSize', 15);
text(qgoal(1), qgoal(2) + 0.2, '$q_{goal}$','Interpreter', 'latex', 'FontSize', 15);

r=0.1;
%  this function finds the RRT path using Dubin as a local planner.
%  distance is based on euclidean distance
Path = RRTDubins(qstart, qgoal,Obstacles,r, [[0, 12],[0, 12]]);
plot(Path(:,1), Path(:,2),'r', 'linewidth',3); title("RRT with dubins using euclidean distance")
xlim([0, 12])
ylim([0,12])
axis equal
saveas(gcf,'RRTdubin_path3','epsc')

% Path D
figure()
[~, Obstacles] = LoadObstacles;
%  this function finds the RRT path using Dubin as a local planner.
%  distance is based on dubin distance
Path = RRTDubinsOpt(qstart, qgoal,Obstacles,r, [[0, 12],[0, 12]]);
text(qstart(1), qstart(2) +0.2, '$q_{start}$','Interpreter', 'latex', 'FontSize', 15);
text(qgoal(1), qgoal(2) + 0.2, '$q_{goal}$','Interpreter', 'latex', 'FontSize', 15);
plot(Path(:,1), Path(:,2),'r', 'linewidth',3); title("RRT with dubins using dubin distance")
xlim([0, 12])
ylim([0,12])
saveas(gcf,'RRTdubins_optt','epsc')
axis equal

% This function allows to easily make a plot of the 4 dubin circles and
% annotations
function dubinsCirclePlot(init, goal, LRcircles,r)
    plot(init(1), init(2),"k*",'MarkerSize',12); hold on;
    plot(goal(1), goal(2),"b*",'MarkerSize',12); hold on;
    cLinit=LRcircles(1,:); cLgoal=LRcircles(2,:); cRinit=LRcircles(3,:);cRgoal=LRcircles(4,:);
    quiver(init(1), init(2), r*cos(init(3)), r*sin(init(3)),'b','Linewidth', 2,'HandleVisibility','off');
    hold on
    quiver(goal(1), goal(2), r*cos(goal(3)), r*sin(goal(3)),'b','Linewidth', 2,'HandleVisibility','off');
    circle(cLinit(1), cLinit(2), r);
    text(cLinit(1),cLinit(2),'L','Color','black','FontSize',14)
    circle(cRinit(1), cRinit(2), r);
    text(cRinit(1),cRinit(2),'R','Color','black','FontSize',14)
    circle(cLgoal(1), cLgoal(2), r);
    text(cLgoal(1), cLgoal(2),'L','Color','black','FontSize',14)
    circle(cRgoal(1), cRgoal(2), r);
    text(cRgoal(1), cRgoal(2),'R','Color','black','FontSize',14)
%     set(h,'Color',[0.8500 0.3250 0.0980]); hold on
end