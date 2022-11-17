close all; clear all; clf; clc;load('Obstacles.mat'); 

G = PGraph(); 
% set(gca,'color',[0.4 0.4 0.4])

for n = 1:numel(Obstacles)
    obstacle = Obstacles{n};
    fill(obstacle(1,:), obstacle(2,:), [0.6,0.6,0.6], 'LineWidth', 1); hold on;
    for m = 1:size(obstacle,2)
        G.add_node(obstacle(:,m));
    end
end

%% Adding start and goal
qstart = ginput(1); 
G.add_node(qstart); 
% plot(qstart(1),qstart(2),"r*");hold on;

start = G.n;
text(qstart(1), qstart(2), '${q_i}$','Interpreter', 'latex', 'FontSize', 18);
qgoal = ginput(1); 
G.add_node(qgoal); 
goal = G.n;
text(qgoal(1), qgoal(2), '${q_f}$','Interpreter', 'latex', 'FontSize', 18);
% plot(qgoal(1),qgoal(2),"r*"); hold on;

G.plot; 



%% discretizing the lengths
Pos = G.coord';
[X1,X2] = meshgrid(Pos(:,1));  [Y1,Y2] = meshgrid(Pos(:,2));
D = ((X1 - X2).^2 + (Y1 - Y2).^2).^(0.5); 
dmin = min(D(D>0));
stepsize = dmin/10;
tic
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
toc
G.plot( 'EdgeColor',[0.5,0.5,0.5],'NodeSize',8, 'NodeFaceColor', 0.8*[1, 0.5, 1]);
tic
[pathAs] = Astar(G, start, goal);
toc
pathAs = G.vertexlist(:,pathAs);
tic
[pathd] = Dijkstra(G, start, goal);
toc
tic
[pathB] = bfs(G, start, goal);
toc
qw{1}=plot(pathAs(1,:),pathAs(2,:), 'y','Linewidth',3);grid off;
hold on;
qw{2}=plot(pathd(1,:),pathd(2,:),'r', 'Linewidth', 3);
hold on;
qw{3}=plot(pathB(1,:),pathB(2,:),'b', 'Linewidth', 3);
legend([qw{:}],["Astar","dijkstra","bfs"])
% legend('show');

