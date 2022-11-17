close all; clear all;
prompt = {'How many tests do you want to run?'};
NTest = 'Number of Test for WaveFront';
definput = {'2'};
dims = [1 40];
opts.Interpreter = 'tex';
% N = inputdlg(prompt,NTest,dims,definput,opts); N = str2double(N{1});
N=1;
for n = 1:N
    tic
    [ax, O] = LoadObstacles; bound = [ax.XLim, ax.YLim]; D = norm(bound([2,4]) - bound([1,3]));
    qstart = [1.5, 1.5];
    plot(qstart(1), qstart(2), 'ok', 'MarkerFaceColor','r', 'MarkerSize', 10);
    text(qstart(1), qstart(2) - 0.05*D, '$q_{start}$','Interpreter', 'latex', 'FontSize', 15);
    qgoal  = [9, 9]; 
    plot(qgoal(1), qgoal(2), 'ok', 'MarkerFaceColor', 'r', 'MarkerSize', 10);
    text(qgoal(1), qgoal(2) - 0.05*D, '$q_{goal}$','Interpreter', 'latex', 'FontSize', 15);
    Path = RRT(O,qstart, qgoal, [ax.XLim, ax.YLim], 0.5, 0.5);
    plot(Path(:,1), Path(:,2), 'linewidth',3);
    toc
end