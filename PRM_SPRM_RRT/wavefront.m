function [bitmap ,G]= wavefront(Obstacles, bitmap, GoalPt)
cost = 2; [s1, s2] = size(bitmap); M=s1;
bitmap(GoalPt(1), GoalPt(2)) = cost;
nghbrs = ones(4,1)*GoalPt + [-1,0;0,1;1,0;0,-1];
while (~isempty(nghbrs))
    Nxt_nghbrs = []; cost = cost + 1;
    for i = 1:size(nghbrs,1)
        m = nghbrs(i,1); n = nghbrs(i,2);
        if(1 <= m && m <= s1 && 1 <= n && n <= s2)
            bitmap(m, n) = cost;
            Nxt_nghbrs = [Nxt_nghbrs; ones(4,1)*[m,n]+ [-1,0;0,1;1,0;0,-1]];
        end
    end
  
    %Eliminate Repeated Indecies

    
    %Eliminate Out of Bounds

    Nxt_nghbrs = Nxt_nghbrs(Nxt_nghbrs(:,1) >= 1 & Nxt_nghbrs(:,1) <= s1 &...
                        Nxt_nghbrs(:,2)>=1 & Nxt_nghbrs(:,2)<= s2, :);
    Nxt_nghbrs = unique(Nxt_nghbrs,'rows');

    %Remove Already Filled
    idx = sub2ind([s1, s2], Nxt_nghbrs(:,1), Nxt_nghbrs(:,2));
    Nxt_nghbrs = Nxt_nghbrs((bitmap(idx) == 0),:);
    
    %Set Next Neighbours to Neighbours
    nghbrs = Nxt_nghbrs;
end
bitmap(bitmap == 1) = s1+s2;
% 
bitmap_nodes = linspace(0,10,M);
G=PGraph();
G.add_node([bitmap_nodes(GoalPt(1)),bitmap_nodes(GoalPt(2))]);
for i =1:M
    for j = 1:M
        q =[bitmap_nodes(i),bitmap_nodes(j)];
        isfree=isFree(q, Obstacles);
        if isfree
            node_id=G.add_node(q);
            G.setcost(node_id, bitmap(i,j))
        end
    end
end    
end