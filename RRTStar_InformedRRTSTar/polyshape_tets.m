[~, Obstacles] = LoadObstacles;

% P = [0 0; 0 2; 2 2; 2 0; NaN NaN; 0.5 0.5; 0.5 1.5; 1.5 1.5; 1.5 0.5; NaN NaN; 3 0.5; 3.5 1.5; 4 0.5; NaN NaN; 3.25 0.6; 3.75 0.6; 3.5 1];
% polyin = polyshape(P);
% plot(polyin)
% xlim([-0.5 4.5])
% ylim([-0.5 2.5])
% 
Q=polyshape({Obstacles{1}(1,:),Obstacles{2}(1,:)},{Obstacles{1}(2,:),Obstacles{2}(2,:)})
plot(Q)
% polyQ=polyshape(Q)