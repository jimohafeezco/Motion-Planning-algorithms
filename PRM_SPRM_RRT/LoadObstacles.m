function [ax, Obstacles] = LoadObstacles
load('Obstacles.mat'); 
f = figure('Color', 'w', 'Position', [20 180 600 450]);
for n = 1:numel(Obstacles)
    obstacle = Obstacles{n};
    fill(obstacle(1,:), obstacle(2,:), [0.6,0.6,0.6], 'LineWidth', 1); hold on;
end
axis([0 10 0 10]);
hold on; grid on;
ax = gca
end