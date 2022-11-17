%% Load Obstacles and hold the axis (Part a)
close all; clear; 
[ax, Obstacles] = LoadObstacles; hold on;
M = 50;xlim=10; ylim=10;
ax.Visible = 'off'; frame = getframe(ax); ax.Visible = 'on'; 
img = imresize(frame.cdata,[M,M]); [s1,s2,s3] = size(img); bit = flipud(rgb2gray(img)); 

bitmap = zeros(s1,s2); bitmap(bit<255) = 1;
%% Wavefront (Part b)
title('select a goal to generate wavefront','FontSize', 15);
qgoal = ginput(1); plot(qgoal(1), qgoal(2), 'ok', 'MarkerFaceColor', 'k', 'MarkerSize', 5);
text(qgoal(1), qgoal(2) - 0.5, '$q_{goal}$','Interpreter', 'latex', 'FontSize', 15);
GoalPt  = floor((flip(qgoal))./([xlim, ylim]).*[s1, s2]) + [1,1];
[bitmap,G] = wavefront(Obstacles, bitmap, GoalPt); 
G.plot('NodeSize',3);
hold on;
%% Add start point for testing 
prompt = {'How many tests do you want to run?'};
NTest = 'Number of Test for WaveFront';
definput = {'2'};
dims = [1 40];
opts.Interpreter = 'tex';
N = inputdlg(prompt,NTest,dims,definput,opts); N = str2double(N{1});
% delete(f); axes(ax);

for n = 1:N
    
    %input your start position
    qstart = ginput(1); plot(qstart(1), qstart(2), 'ok', 'MarkerFaceColor','k', 'MarkerSize', 5);
    text(qstart(1), qstart(2) - 0.5, '$q_{start}$','Interpreter', 'latex', 'FontSize', 15);
    StartPt = floor((flip(qstart))./([xlim,ylim]).*[s1, s2]) + [1,1];
    %BFS with steepest gradient
    path = BFSpath(bitmap, StartPt); m = size(path,1);
    % convert xy
    Pathxy = fliplr((path - ones(m,1)*[1,1]).*(ones(m,1)*[ax.XLim(2), ax.YLim(2)] - [ax.XLim(1), ax.YLim(1)])./(ones(m,1)*[s1,s2]) + ones(m,1)*[ax.XLim(1), ax.YLim(1)]);
    %plot path
    plot(Pathxy(:,1), Pathxy(:,2), 'linewidth', 3);
end


f = figure(2); 
dx = diff(ax.XLim)/M; dy = diff(ax.YLim)/M;
[X,Y] = meshgrid(dy*(0.5:1:M),dx*(0.5:1:M));
surf(X,Y,bitmap);
pause(2.5);
% clear;
n = 100; r = 4; n =50; r=3; step=0.1;
[~, Obstacles] = LoadObstacles;
O = Obstacles;  % Environment 
% Number of samples
% Radius of proximity for function near
% Step for collision checking in a straight line

%% PRM (Part c)

[G]=SPRM(O, n, r, step);
title('select a start & goal point to generate path from PRM','FontSize', 10);
G.plot();
hold on;
G = sprmquery(G,O,step, r);
G.plot();
G.highlight_node(M+1);
G.highlight_node(M+2);
path = G.Astar(51,52);
pathxy= G.coord(path);

plot(pathxy(1,:), pathxy(2,:), 'r','linewidth', 3);
pause(2.5);


%% PRM (Part d)
n = 100; r = 4; step=0.1;
[~, Obstacles] = LoadObstacles;
O = Obstacles;  % Environment 
title('select a start & goal point to generate path from sPRM','FontSize', 10);
[G]=PRM(O, n, r, step);
G.plot();
hold on;
G = sprmquery(G,O,step, r);
G.plot();

%% PRM (Part e)
G.highlight_node(n+1);
G.highlight_node(n+2);
path = G.Astar(n+1,n+2);
pathxy= G.coord(path);

plot(pathxy(1,:), pathxy(2,:), 'r','linewidth', 3);

prompt = {'How many tests do you want to run?'};
NTest = 'Number of Test for WaveFront';
definput = {'2'};
dims = [1 40];
opts.Interpreter = 'tex';
N = inputdlg(prompt,NTest,dims,definput,opts); N = str2double(N{1});
N=2;
for n = 1:N
    [ax, O] = LoadObstacles; bound = [ax.XLim, ax.YLim]; D = norm(bound([2,4]) - bound([1,3]));
    qstart = ginput(1);
    plot(qstart(1), qstart(2), 'ok', 'MarkerFaceColor','r', 'MarkerSize', 10);
    text(qstart(1), qstart(2) - 0.05*D, '$q_{start}$','Interpreter', 'latex', 'FontSize', 15);
    qgoal  = ginput(1); 
    plot(qgoal(1), qgoal(2), 'ok', 'MarkerFaceColor', 'r', 'MarkerSize', 10);
    text(qgoal(1), qgoal(2) - 0.05*D, '$q_{goal}$','Interpreter', 'latex', 'FontSize', 15);
    Path = RRT(O,qstart, qgoal, [ax.XLim, ax.YLim], 0.5, 0.5);
    plot(Path(:,1), Path(:,2), 'linewidth',3);
end
