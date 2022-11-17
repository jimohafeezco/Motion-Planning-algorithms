function [G] =PRM(O, n, r, step)
G = SampleFree(n, O);
% Line 2
for v = 1 : n
    % Line 3
    U = Near(G, v, r);
    % Line 4
    for u=U
        % Line 5
        path = G.Astar(u, v);
        if(isempty(path))
            if CollisionFree(G,u,v,step,O)
                G.add_edge(u,v);
            end
        end
    end
end
end