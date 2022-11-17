function [G,cost_rrt]= RRTx_Informed(qstart,qgoal,polyObs,n,stepsize)
G = PGraph();
G.add_node(qstart);
G.setvdata(1,{0,0});
% n = 1000;
tol =1 ;  %goal radius
c_max = 0;
cmin=norm(qgoal-qstart);
% th = title('iteration #1');

%%
% while(norm(G.coord(G.n) - qgoal') > tol)
for iteration = 1:n
    if c_max ~= 0 %&& c_max >cmin
        qnew =  SampleBall(qstart, qgoal, c_max);
    else
        q = [rand*(100);rand*(100)]';
        c = G.closest(q);
        qnew = G.coord(c)' + (stepsize*(q - G.coord(c)')/norm(q -G.coord(c)'));
    end
    p1 = qnew;
    p2 = G.coord(c)';
    if isFreep(qnew,polyObs) && CollisionFree2D(p1,p2, polyObs)
        [D,W] = G.distances(qnew);
        RRTx_r = NearestRadius(G, stepsize,polyObs);
        X_near = W(D<RRTx_r);
        G.add_node(qnew);
        c_L = pdist([p1;p2]);  % cost of line
        c_V = G.vdata(c); % cost of vertex from root
        c_min = c_V{1} + c_L;
        x_min = c;
%         set(th, 'String', sprintf('iteration #%d', iteration));
        title(['RRTx Informed at n = ',num2str(iteration)]);

%           disp(['RRT star Informed:',num2str(iteration/n*100),'%'])
        for j = 1:length(X_near)
            point1 = qnew;
            point2 = G.coord(X_near(j))';
            c_l = pdist([point1;point2]);
            c_n = G.vdata(X_near(j));
            cost = c_l + c_n{1};
            if  CollisionFree2D(point1,point2, polyObs) && cost < c_min
                x_m = X_near(j);
                c_m = cost;
            end
        end
        if exist('x_m','var') == 1
            G.add_edge(G.n,x_m);
            G.setvdata(G.n,{c_m,x_m});
        else
            G.add_edge(G.n,x_min);
            G.setvdata(G.n,{c_min,x_min});
        end
        
        clear x_m c_m
        for k = 1:length(X_near)   % Rewire
            point1 = qnew;
            point2 = G.coord(X_near(k))';
            c_l = pdist([point1;point2]);
            c_n = G.vdata(G.n);
            cst = c_l + c_n{1};  % cost to get to x_near from qnew
            c_p = G.vdata(X_near(k));
            if  CollisionFree2D(point1,point2, polyObs)  && cst < c_p{1}
                x_parent = G.n;
                xnear = X_near(k);
                pr = G.vdata(xnear);
                ge = G.edgelist';
                I = find(ge(:, 1) == pr{2} & ge(:, 2) == xnear );
                J=find(ge(:, 1) == xnear & ge(:, 2) ==  pr{2} );
                if isempty(I)
                    G.delete_edge(J);
                else
                    G.delete_edge(I);
                end
                G.add_edge(x_parent,xnear);
                G.setvdata(xnear,{cst,x_parent});
                child =  DFS(G,xnear);
                    if ~isempty(child)
                    for ch = 1: size(child,1)
                        nc= G.vdata(child(ch,2));
                        pt1= G.coord(child(ch,1))';
                        pt2= G.coord(child(ch,2))';
                        new_cost = nc{1}+ pdist([pt1;pt2]) ;
                        G.vdata(child(ch,1));
                        G.setvdata(child(ch,1),{new_cost,child(ch,2)});
                    end
                    end
                
            end
        end
    end
    
    if ((norm(G.coord(G.n) - qgoal')) < tol)
        tempC= G.vdata(G.n);
        c_max = tempC{1};
    end
end

G.plot('NodeSize',6);
G.highlight_node(1);

plot(qgoal(1), qgoal(2), '*r')

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
plot(Path(:,1), Path(:,2), 'r', 'Linewidth', 3)
% title(['RRTx Informed at n = ',num2str(n)])
cost_rrt=norm(Path(:,1)-Path(:,2));
% axis([-5 110 -5 110]);
end