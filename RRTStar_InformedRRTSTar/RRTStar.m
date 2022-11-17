function [G,cost]= RRTStar(qstart,qgoal,polyObs,n,stepsize)
G = PGraph();
G.add_node(qstart);
G.setvdata(1,{0,0});
% n=0;
tol=1;
% while(norm(G.coord(G.n) - qgoal') > tol)
for iteration = 1:n
    q = [rand*(100);rand*(100)]'; c = G.closest(q);
    qnew = G.coord(c)' + (stepsize*(q - G.coord(c)')/norm(q -G.coord(c)'));

    if isFreep(qnew,polyObs) && CollisionFree2D(qnew, G.coord(c)',polyObs)
        [D,W] = G.distances(qnew);
        RRTx_r = NearestRadius(G, stepsize,polyObs);
        X_near = W(D<RRTx_r);
        G.add_node(qnew);
        title(['RRTx at n = ',num2str(iteration)]);
        c_V = G.vdata(c); 
        c_min = c_V{1} + pdist([qnew;G.coord(c)']); 
        x_min = c;
        for j = 1:length(X_near)
            c_n = G.vdata(X_near(j));
            cost = c_n{1} +pdist([qnew; G.coord(X_near(j))']); ;
            if  CollisionFree2D(qnew, G.coord(X_near(j))', polyObs) && cost < c_min
                x_m = X_near(j);
                c_m = cost;
            end
        end
        if exist('x_m','var')
            G.add_edge(G.n,x_m); X_m= G.coord(x_m)';
            drawnow
            G.setvdata(G.n,{c_m,x_m});
        else
            G.add_edge(G.n,x_min); X_min= G.coord(x_min)';
            drawnow
            G.setvdata(G.n,{c_min,x_min});
        end
        clear x_m c_m
        for k = 1:length(X_near)   % Rewire
            c_n = G.vdata(G.n);
            cst = c_n{1}+ pdist([qnew;G.coord(X_near(k))']);  % cost to get to x_near from qnew
            c_p = G.vdata(X_near(k));
            if CollisionFree2D(qnew, G.coord(X_near(k))',polyObs)&& cst < c_p{1}
                x_parent = G.n;
                pr = G.vdata(X_near(k));
                ge = G.edgelist';
                I = find(ge(:, 1) == pr{2} & ge(:, 2) == X_near(k) );
                J=find(ge(:, 1) == X_near(k) & ge(:, 2) ==  pr{2} );
                if isempty(I)
                    G.delete_edge(J);
                else
                    G.delete_edge(I);
                end
                G.add_edge(G.n,X_near(k)); xnear= G.coord(X_near(k))';
                G.setvdata(X_near(k),{cst,x_parent});
                child =  DFS(G,X_near(k));
                if ~isempty(child)
                    for ch = 1:size(child,1)
                        nc= G.vdata(child(ch,2));
                        pt1= G.coord(child(ch,1))';
                        pt2= G.coord(child(ch,2))';
                        new_cost = nc{1}+ pdist([pt1;pt2]) ;
                        G.vdata(child(ch,1));
                        G.setvdata(child(ch,1),{new_cost,child(ch,2)});
                    end
                end
                %run dfs, find all children , recalculate cost for all
                %children
            end
        end
    end
end


%%
% figure(2)
G.plot('NodeSize',6);
G.plot('NodeSize',6);
G.highlight_node(1);

hold on
goal= G.closest(qgoal);
G.highlight_node(goal);

xc= G.vdata(goal);
path = [goal];
while goal ~= 1
    goal = G.vdata(goal);
    goal= goal{2};
    path= [path;goal];
end
Path = G.vertexlist(:,path)';
cost_rrt=norm(Path(:,1)-Path(:,2));

% plot(A)
% hold on
plot([Path(:,1)], [Path(:,2)], 'r', 'Linewidth', 3)
% title(['RRTx at n = ',num2str(n)])
% axis([-5 110 -5 110]);
