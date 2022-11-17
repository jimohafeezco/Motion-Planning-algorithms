function [child] =  DFS(G,s)

% h = 1;
C = [0 0];
O=[s 0];

while ~isempty(O)
    u = O(1,1);
    bp = O(1,2);
%     h = h+1;
    if(~ismember(u, C(:,1)))
        C= [C; u bp];
        ng = G.neighbours_out(u);
        if (~isempty(ng))
        for i = 1:(length(ng))
            in= ismember(ng(i), C(:,1));
            if in==0
                O= [O; ng(i) u]; 
            end
        end
        end
    end
        O(1,:)=[];
end 
C(1,:)= [];
C(1,:)= [];
child= C;
end
