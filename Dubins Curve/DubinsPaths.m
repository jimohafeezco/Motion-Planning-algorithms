% % C= {vs, vg, qs , qg, p1Linit, p1Lgoal, cLinit, cLgoal},
function [M,SP, name] = DubinsPaths(start, goal, r, dir1, dir2)
figure (1)
t = tiledlayout(2,2);t.TileSpacing = 'none';t.Padding = 'none';
nexttile; hold on; axis equal;set(gca,'xtick',[]); set(gca,'ytick',[])
title('LSL')
text(start(1,1), start(1,2), '{\bf start}','Interpreter', 'latex', 'FontSize', 12);
plot(goal(1,1), goal(1,2), 'sk', 'MarkerFaceColor','k', 'MarkerSize', 3);
text(goal(1,1), goal(1,2), '{\bf goal}','Interpreter', 'latex', 'FontSize', 12);
[CostLSL, pathlsl, C] = LSL(start, goal,r, dir1, dir2);
plot(pathlsl(:,1) , pathlsl(:,2), 'r-', 'Linewidth', 3);
box on;
quiver(C{1,3}(1), C{1,3}(2), r*C{1,1}(1), r*C{1,1}(2), 'k')
circle(C{1,7}(1), C{1,7}(2), r);
quiver(C{1,4}(1), C{1,4}(2), r*C{1,2}(1), r*C{1,2}(2), 'k')
circle(C{1,8}(1), C{1,8}(2), r);
%%
nexttile; hold on; axis equal;set(gca,'xtick',[]); set(gca,'ytick',[])
title('RSL')
[CostRSL, pathrsl, L]= RSL(start, goal, r, dir1, dir2);
text(start(1,1), start(1,2), '{\bf start}','Interpreter', 'latex', 'FontSize', 12);
plot(goal(1,1), goal(1,2), 'sk', 'MarkerFaceColor','k', 'MarkerSize', 3);
text(goal(1,1), goal(1,2), '{\bf goal}','Interpreter', 'latex', 'FontSize', 12);
plot(pathrsl(:,1) , pathrsl(:,2), 'b-', 'Linewidth', 3);
box on;
quiver(L{1,3}(1), L{1,3}(2), r*L{1,1}(1), r*L{1,1}(2), 'k')
circle(L{1,7}(1), L{1,7}(2), r);
quiver(L{1,4}(1), L{1,4}(2), r*L{1,2}(1), r*L{1,2}(2), 'k')
circle(L{1,8}(1), L{1,8}(2), r);
%%
nexttile; hold on; axis equal;set(gca,'xtick',[]); set(gca,'ytick',[])
title('LSR')
[CostLSR, pathlsr, D] = LSR (start, goal, r, dir1, dir2);
text(start(1,1), start(1,2), '{\bf start}','Interpreter', 'latex', 'FontSize', 12);
plot(goal(1,1), goal(1,2), 'sk', 'MarkerFaceColor','k', 'MarkerSize', 3);
text(goal(1,1), goal(1,2), '{\bf goal}','Interpreter', 'latex', 'FontSize', 12);
plot(pathlsr(:,1) , pathlsr(:,2), 'g-', 'Linewidth', 3);
box on;
quiver(D{1,3}(1), D{1,3}(2), r*D{1,1}(1), r*D{1,1}(2), 'k')
circle(D{1,7}(1), D{1,7}(2), r);
quiver(D{1,4}(1), D{1,4}(2), r*D{1,2}(1), r*D{1,2}(2), 'k')
circle(D{1,8}(1), D{1,8}(2), r);
%%
nexttile; hold on; axis equal;set(gca,'xtick',[]); set(gca,'ytick',[])
title('RSR')
[CostRSR, pathrsr, R] = RSR (start, goal, r, dir1, dir2);
text(start(1,1), start(1,2), '{\bf start}','Interpreter', 'latex', 'FontSize', 12);
plot(goal(1,1), goal(1,2), 'sk', 'MarkerFaceColor','k', 'MarkerSize', 3);
text(goal(1,1), goal(1,2), '{\bf goal}','Interpreter', 'latex', 'FontSize', 12);
plot(pathrsr(:,1) , pathrsr(:,2), 'k-', 'Linewidth', 3);
box on;
quiver(R{1,3}(1), R{1,3}(2), r*R{1,1}(1), r*R{1,1}(2), 'r')
circle(R{1,7}(1), R{1,7}(2), r);
quiver(R{1,4}(1), R{1,4}(2), r*R{1,2}(1), r*R{1,2}(2), 'r')
circle(R{1,8}(1), R{1,8}(2), r);
%%
M = [CostLSL, CostRSL, CostLSR, CostRSR];
%%
figure (2)
set(gca,'xtick',[]); set(gca,'ytick',[])
hold on;axis equal;
SP = min(M);
if SP == M(1)
    name = 'LSL';
    text(start(1,1), start(1,2), '{\bf start}','Interpreter', 'latex', 'FontSize', 12);
    plot(goal(1,1), goal(1,2), 'sk', 'MarkerFaceColor','k', 'MarkerSize', 3);
    text(goal(1,1), goal(1,2), '{\bf goal}','Interpreter', 'latex', 'FontSize', 12);
    plot(pathlsl(:,1) , pathlsl(:,2), 'r-', 'Linewidth', 3);
    quiver(C{1,3}(1), C{1,3}(2), r*C{1,1}(1), r*C{1,1}(2), 'k')
    circle(C{1,7}(1), C{1,7}(2), r);
    quiver(C{1,4}(1), C{1,4}(2), r*C{1,2}(1), r*C{1,2}(2), 'k')
    circle(C{1,8}(1), C{1,8}(2), r);
elseif SP == M(2)
    name = 'RSL';
    text(start(1,1), start(1,2), '{\bf start}','Interpreter', 'latex', 'FontSize', 12);
    plot(goal(1,1), goal(1,2), 'sk', 'MarkerFaceColor','k', 'MarkerSize', 3);
    text(goal(1,1), goal(1,2), '{\bf goal}','Interpreter', 'latex', 'FontSize', 12);
    plot(pathrsl(:,1) , pathrsl(:,2), 'b-', 'Linewidth', 3);
    quiver(L{1,3}(1), L{1,3}(2), r*L{1,1}(1), r*L{1,1}(2), 'k')
    circle(L{1,7}(1), L{1,7}(2), r);
    quiver(L{1,4}(1), L{1,4}(2), r*L{1,2}(1), r*L{1,2}(2), 'k')
    circle(L{1,8}(1), L{1,8}(2), r);
elseif SP == M(3)
    name = 'LSR';
    text(start(1,1), start(1,2), '{\bf start}','Interpreter', 'latex', 'FontSize', 12);
    plot(goal(1,1), goal(1,2), 'sk', 'MarkerFaceColor','k', 'MarkerSize', 3);
    text(goal(1,1), goal(1,2), '{\bf goal}','Interpreter', 'latex', 'FontSize', 12);
    plot(pathlsr(:,1) , pathlsr(:,2), 'g-', 'Linewidth', 3);
    quiver(D{1,3}(1), D{1,3}(2), r*D{1,1}(1), r*D{1,1}(2), 'k')
    circle(D{1,7}(1), D{1,7}(2), r);
    quiver(D{1,4}(1), D{1,4}(2), r*D{1,2}(1), r*D{1,2}(2), 'k')
    circle(D{1,8}(1), D{1,8}(2), r);
else
    name = 'RSR';
    text(start(1,1), start(1,2), '{\bf start}','Interpreter', 'latex', 'FontSize', 12);
    plot(goal(1,1), goal(1,2), 'sk', 'MarkerFaceColor','k', 'MarkerSize', 3);
    text(goal(1,1), goal(1,2), '{\bf goal}','Interpreter', 'latex', 'FontSize', 12);
    plot(pathrsr(:,1) , pathrsr(:,2), 'k-', 'Linewidth', 3);
    quiver(R{1,3}(1), R{1,3}(2), r*R{1,1}(1), r*R{1,1}(2), 'r')
    circle(R{1,7}(1), R{1,7}(2), r);
    quiver(R{1,4}(1), R{1,4}(2), r*R{1,2}(1), r*R{1,2}(2), 'r')
    circle(R{1,8}(1), R{1,8}(2), r);
end
box on
title(['Shortest path is ',name,])
end