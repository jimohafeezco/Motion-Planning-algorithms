function [G,cost_rrt] = RRT(O,polyObs,qstart, qgoal, stepsize, N)
%RRT Summary of this function goes here
%   Detailed explanation goes here
step=0.1;
G = PGraph();
tol=1;
G.add_node(qstart); parent = 0;
% while(norm(G.coord(G.n) - qgoal') > tol)
for iteration =1:N
    q = [rand*(100);rand*(100)]'; c = G.closest(q);  qc=G.coord(c)';
    qnew = G.coord(c)' + (stepsize*(q - G.coord(c)')/norm(q -G.coord(c)'));
% % %     check that qnew is not out of bound, if ourt of bound, use the
% bound limit has qnew
    qnew(1) = max(min(qnew(1),100));
    qnew(2) = max(min(qnew(2),100));
    if isFree(qnew,O) && CollisionFree2D(qnew, qc,polyObs)
%     if(isFree(qnew',O))  &&  CollisionFree(G, c, G.n, step, O) 
        end2end = linspace(0,1,50); f = end2end(2:end-1)';
        pts = ones(size(f))*qc + f*(qc - qnew); 
%         if(isFree(pts,O)) && isPathFree([qnew'; G.coord(c)'], O)
        if(isFree(pts,O)) 
            G.add_node(qnew);
            G.add_edge(G.n, c);
            parent = [parent, c];
        end
    end
end
G.plot('NodeSize',6);
G.highlight_node(1);

hold on
goal= G.closest(qgoal);
G.highlight_node(goal);

path = [G.n];
Path = [G.coord(G.n)';qgoal];
hasparent = 1;
while hasparent
    path = [parent(path(1)),path];
    Path = [G.coord(path(1))';Path];
    if(path(1) == 0) 
        path = [];
        break;
    else
        hasparent = parent(path(1))> 0;
    end
end
plot(Path(:,1), Path(:,2),'r','linewidth',3);
% title(['RRT at n = ',num2str(N)])
cost_rrt=norm(Path(:,1)-Path(:,2));

end
