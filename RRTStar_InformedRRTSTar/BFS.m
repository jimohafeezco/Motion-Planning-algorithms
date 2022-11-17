function path = BFS(G, start, goal)
parent = zeros(G.n, 1);
for n = 1:G.n
    parent(n) = 0;
end

O = start;
C = [];

while ~isempty(O)
    u = O(1); O = O(O~=u); 
    if(~ismember(u, C))
        C = [C, u];
        nghbrs = G.neighbours(u);
        O = [O,nghbrs(~ismember(nghbrs, C))];
        parent(nghbrs(~ismember(nghbrs, C))) = u;
    end
end

path= [goal];
hasparent = 1;

while hasparent
    path = [parent(path(1)),path];
    if(path(1) == 0) 
        path = [];
        break;
    else
        hasparent = parent(path(1))> 0;
    end
end