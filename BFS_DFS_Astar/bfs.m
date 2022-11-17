function pathB =bfs(G, start, goal)
    n = G.n;
    e = G.n;
    O = zeros(n+e, 2);
    top = 1;
    bottom = 1;

    C = zeros(goal, 2);

    V  = start; % Initial node

    % Add V to O
    O(bottom, 1) = V;
    O(bottom, 2) = V;       % backpointer
    bottom = bottom + 1;
    if bottom > length(O)
        bottom = 1;
    end

    while (top ~= bottom)
        u = O(top,:);
        top = top + 1;
        if top > length(O)
            top = 1;
        end
        if C(u(1),1) == 0
            C(u(1),1) = 1;    % mark that u is in C
            C(u(1),2) = u(2); % store the backpointer
            neighbors = G.neighbours(u(1));
            for ne = neighbors
                if C(ne,1) == 0             % check if the neighbor is in C
                        O(bottom,1) = ne;   % Add the neighbor to set O
                        O(bottom,2) = u(1); % Add the backpointer of the neighbor to O. 
                        bottom = bottom + 1;
                        if bottom > length(O)
                            bottom = 1;
                        end
                end
            end
        end
    end
% 
    i = 1;
    path(i) = goal;
    bk = C(goal,2);
    i=i+1;
    while bk ~= start
        path(i) = bk;
        bk = C(bk,2);
        i=i+1;
    end
%     a=goal;
%     B= [goal];
%     while a ~= start
%        a = C(a,2)
%        B= [B a];
%     end
    path(i) = start;
% 
    path = path(end:-1:1);
    pathB = G.vertexlist(:,path);

end