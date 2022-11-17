close all; clear all; clf; load('Obstacles.mat'); 
% f = figure('Position', [680 494 685 484]); hold on;
% axis(Obstacles{1}); 

%% Construct the graph (Add nodes to graph)
G = PGraph(); 

for n = 1:numel(Obstacles)
    obstacle = Obstacles{n};
    fill(obstacle(1,:), obstacle(2,:), [0.6,0.6,0.6], 'LineWidth', 1); hold on;
    for m = 1:size(obstacle,2)
        G.add_node(obstacle(:,m));
    end
end

%% Add start and goal
qstart = ginput(1); 
G.add_node(qstart); 
start = G.n;
text(qstart(1), qstart(2) - 0.5, '${start}$','Interpreter', 'latex', 'FontSize', 15);
qgoal = ginput(1); 
G.add_node(qgoal); 
goal = G.n;
text(qgoal(1), qgoal(2) - 0.5, '${goal}$','Interpreter', 'latex', 'FontSize', 15);

%% take a peep at the graph


G.plot; 



%% Estimate reasonable stepsize for descritizinf the lengths
Pos = G.coord';
[X1,X2] = meshgrid(Pos(:,1));  [Y1,Y2] = meshgrid(Pos(:,2));
D = ((X1 - X2).^2 + (Y1 - Y2).^2).^(0.5); 
dmin = min(D(D>0));
stepsize = dmin/10;

%% Construct visibility graph
for n = 1:G.n
    for m = 1:G.n
        if(n ~= m)
            line1 = G.vertexlist(:,[n,m])';
            pts = discretizeLine(line1, stepsize);
            isfree = 1;
            for r = 1:size(pts,1)
                isfree = isfree && isFree(pts(r,:), Obstacles);
                if ~isfree
                    break;
                end
            end
            if(isfree) 
                G.add_edge(n, m);
            end
        end
    end
end
G.plot;

path = bfs(G, start, goal);

% v = G.vertexlist(:,path);
plot(path(1,:),path(2,:), 'linewidth', 5);