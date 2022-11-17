function [cost, path, name]= shortest_path(init, goal,LRcircles, r)
% this function returns the cost and path for the minimum cost out of the 4
% dubin configurations
cLinit=LRcircles(1,:);
cLgoal=LRcircles(2,:);
cRinit=LRcircles(3,:);
cRgoal=LRcircles(4,:);
% % %  Calculate cost and path for each of dubin configuration
[CostLSL, pathlsl, ~] = LSL(init, goal, cLinit',cLgoal',r);
[CostLSR, pathlsr, ~] = LSR(init, goal,cLinit',cRgoal',r);
[CostRSR, pathrsr, ~] = RSR(init, goal,cRinit',cRgoal',r);
[CostRSL, pathrsl, ~] = RSL(init, goal,cRinit',cLgoal',r);
% legend("init","goal","LSL","LSR","RSR","RSL")

% determine which of the 4 dubin path is minimum
M = [CostLSL, CostLSR, CostRSL, CostRSR];
SP = min(M);
if SP == M(1)
    cost = CostLSL;
    path = pathlsl;
    name = "LSL";
elseif SP == M(2)
    cost = CostLSR;
    path = pathlsr;
    name = "LSR";
elseif SP == M(3)
    cost = CostRSL;
    path = pathrsl;
    name = "RSL";
else
    cost = CostRSR;
    path = pathrsr;
    name = "RSR";
end

end