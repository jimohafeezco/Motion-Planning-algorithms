function G = sprmquery(G,O,step, r)

start= ginput(1); 
text(start(1), start(2) - 0.5, '$q_{start}$','Interpreter', 'latex', 'FontSize', 15);
goal = ginput(1); 
text(goal(1), goal(2) - 0.5, '$q_{goal}$','Interpreter', 'latex', 'FontSize', 15);
% add initial position to the graph
init = start;
G.add_node(init);
near= Near(G, G.n, r); % G.n is the number of the node at init
for v=near
    if CollisionFree(G, v, G.n, step, O) 
        G.add_edge(v, G.n);
%         break;        % If we break, we will connect with a single edge 
    end
end
% add goal position to the graph
G.add_node(goal);
near= Near(G, G.n, r);
for v=near
    if CollisionFree(G, v, G.n, step, O) 
        G.add_edge(v, G.n);
%         break;
    end
end

end
