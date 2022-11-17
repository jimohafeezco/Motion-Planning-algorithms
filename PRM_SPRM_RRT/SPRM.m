function [G] =SPRM(Obstacle,qstart, qgoal, n, r, step)
G = SampleFree(n, Obstacle);
% Line 2
for v = 1 : n
    % Line 3
    U = Near(G, v, r);
    % Line 4
    for u=U
        % Line 5
        if CollisionFree(G,u,v,step,Obstacle)
            G.add_edge(u,v);
        end    
    end
end

init = qstart;
G.add_node(init);
near= Near(G, G.n, r); % G.n is the number of the node at init
for v=near
    if CollisionFree(G, v, G.n, step, Obstacle) 
        G.add_edge(v, G.n);
%         break;        % If we break, we will connect with a single edge 
    end
end
% add qgoal position to the graph
G.add_node(qgoal);
near= Near(G, G.n, r);
for v=near
    if CollisionFree(G, v, G.n, step, Obstacle) 
        G.add_edge(v, G.n);
%         break;
    end
end
G.plot();

end