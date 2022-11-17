function [pathAs] = Astar(G, start, goal)
N = goal;
ge = G.edgelist';
e = goal;
O = zeros(3*goal, 4);

head_O = 1;
tail_O = 1;
tail_OO = 1;
% Init set c
SetC = zeros(N,2);
v = start;
% Add set v to Set o
O(tail_O,:) = [v v 0 0];
O(2,:) = [v v 0 0];
tail_O = tail_O + 1;
tail_OO = tail_OO +1;
if(tail_O>N)
    tail_O = 1;
end

while (head_O ~= tail_OO)
    % remove u from o
    O( ~any(O,2), : ) = [];
    O(1,:) = [];
    % if u is not an element of C
    O = sortrows(O,4);
    u = O(1,1);
    bu = O(1,2);
    head_O = head_O+1;
    if (SetC(u,1)==0)
        
        % add u to c
        SetC(u,:)=[1 bu];
        % add all the neighbours of u that are not in C to o
        ng = G.neighbours_out(u);
       
        for i = 1:length(ng)
            if (SetC(ng(i),1)==0)
                I = find(ge(:, 1) == ng(i) & ge(:, 2) == u);
                Cost = G.cost(I);
                H = norm(G.coord(ng(i)) - G.coord(N));
                Fn = H+Cost;
                O(tail_OO,:) = [ng(i) u Cost Fn];
%                 tail_O = tail_O + 1;
                tail_OO = tail_OO +1;
                if(tail_O>N)
                    tail_O = 1;
                end          
            end
        end
        tail_O = tail_O + 1;        
    end        
end
a = goal;
B = [N];
while a~=N-1;
    
    a = SetC(a,2);
    B = [B a];
end
pathAs = B;
% pathAs = G.vertexlist(:,pathAs);

end