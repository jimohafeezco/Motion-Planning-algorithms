% press n to end specifying coordinates of obstacle and beging speicfying
% another

clear all; close all; clc;
% specify the number of obstacle you want for numObs in the configuration space
numObs=8;
Obstacles=Obstacles2d(numObs);    
save Obstacles ;



function Obstacles = Obstacles2d(numObs)
    close all;
    f=figure; grid on;ax=gca;hold on;
    axis([0 10 0 10])
    Obstacles ={};
    for n =1:numObs
        button =0;
        xpoints = [];
        ypoints = [];
        while (button ~= 110 && n < numObs+1)
            [X,Y, button]=ginput(1);
            xpoints(end+1)=X;
            ypoints(end+1)=Y;
            plot([xpoints],[ypoints]); hold on;
            plot([xpoints],[ypoints],'r*');
            title("press n to plot plot next obstacle")
            axis([0 10 0 10])
        end
        plot([xpoints],[ypoints]);
 
        hold on;
        fill([xpoints],[ypoints],[0.5,0.5,0.5],'Linewidth', 1)
%         Obstacles.(sprintf('%d',n))=[xpoints;xpoints];
        Obstacles = [Obstacles,[xpoints;ypoints]];
        button=0;
    end
end
