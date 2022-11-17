function Path = RRTDubinsOpt(qstart, qgoal,Obstacle,r, bound)
stepsize=1.5; tol=0.5;diagonal = norm(diff(reshape(bound,2,2)));
G = PGraph();
G.add_node(qstart); G.setvdata(1, Direction([qstart;qgoal])); parent = 0;
while(norm(G.coord(G.n) - qgoal') > tol)
    qrand = [bound(1) + rand*(bound(2) - bound(1)); bound(3) + rand*(bound(4) - bound(3))];
%     c = G.closest(qrand); 
    c = closestbyDubin(G, qrand, diagonal, tol); 
    if(c > 0)
        qc = G.coord(c)';
        length = norm(qrand - G.coord(c));
        qnew = G.coord(c) + stepsize*(qrand - G.coord(c))/length;
        qnew(1) = max(min(qnew(1),bound(2)),bound(1));
        qnew(2) = max(min(qnew(2),bound(4)),bound(3));
        if(isFree(qnew', Obstacle))  %% checking if qnew is not on obstacle free
            dir2 = Direction([qc;qnew']);
            init = [qc, G.vdata(c)]; goal= [qnew', dir2];
            [LRcircles] =dubin_circles(init, goal, r);
            [~, points,~]= shortest_path(init, goal,LRcircles, r); 
% %             check if the path is obstacle free
            if(isPathFree(points, Obstacle)) && isPathFree([qc;qnew'], Obstacle)
                G.add_node(qnew);
                G.setvdata(G.n, dir2);
                G.add_edge(G.n, c);
                G.setedata(G.n-1, points);
                parent = [parent, c];
            end
        end
    end
end
G.plot;
path = [G.n];
Path = qgoal;
hasparent = 1;
while hasparent
    path = [parent(path(1)),path];
    Path = [G.edata(path(2) - 1);Path];
    if(path(1) == 0) 
        path = [];
        break;
    else
        hasparent = parent(path(1))> 0;
    end
end

function dir = Direction(line)
dir = diff(line); dir = dir/norm(dir); 

% determine distance base on dubin
function n = closestbyDubin(Graph, qrand, radius, rc)
[V,D] = Graph.closest(qrand) ;
V = V(D <= radius);
d = radius; n = 0;
for m = V
    pt = Graph.coord(m)';
    dir = Direction([pt;qrand']);
    init= [pt, Graph.vdata(m)]; goal = [qrand', dir];
    [LRcircles] =dubin_circles(init, goal, rc);
    [~, cst,~] =shortest_path(init, goal,LRcircles, rc); 
    if(cst < d)
        d = cst; n = m;
    end
end


