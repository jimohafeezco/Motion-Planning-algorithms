% press n to end specifying coordinates of obstacle and beging speicfying
% another
% specify the number of obstacle you want for numObs in the configuration space

clear all; close all; clc;
numObs=3 ;
Obstacles=Obstacles2d(numObs);
% for n = 1:15
%     q = ginput(1);
%     isfree= isFree(q, Obstacles);
%     disp(isfree);
%     isfee=1;
%     color_obs = 'blue'
%     if ~isfree
%         color_obs='red'
%     end
%     plot(q(1),q(2),'-s','MarkerSize',5,'MarkerEdgeColor','red','MarkerFaceColor',color_obs);
%     
% end

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
    save Obstacles Obstacles;
end
% function isfree = isFree(q, Obstacles)
% isfree = 1;
%     numObs= length(Obstacles);
%     for n = 1:numObs
%        isfree = isfree && (~inpolygon(q(1), q(2), Obstacles{n}(1,:),Obstacles{n}(2,:)));
%        if ~isfree
%            break;
%         end
%     end
% end