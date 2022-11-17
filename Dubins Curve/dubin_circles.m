function [LRcircles] =dubin_circles(init, goal, r)
    % Directional vector

    vinit=[cos(init(3)), sin(init(3))];

    % Vector orthogonal to the direction
    vinitO = [vinit(2) -vinit(1)];
    % Directional vector
    vgoal=[cos(goal(3)), sin(goal(3))];

    % Vector orthogonal to the direction
    vgoalO = [vgoal(2) -vgoal(1)];

    % Center of the circles for goal
    cLgoal = vgoalO*-r+goal(1:2);
    cRgoal = vgoalO*r+goal(1:2);


    % Center of the circles for init
    cLinit = vinitO*-r+init(1:2);
    cRinit = vinitO*r+init(1:2);
%     circle(cLinit(1), cLinit(2), r);
% %     text(cLinit(1),cLinit(2),'L','Color','red','FontSize',14)
%     circle(cRinit(1), cRinit(2), r);
% %     text(cRinit(1),cRinit(2),'R','Color','red','FontSize',14)
%     circle(cLgoal(1), cLgoal(2), r);
% %     text(cLgoal(1), cLgoal(2),'L','Color','red','FontSize',14)
%     circle(cRgoal(1), cRgoal(2), r);
% %     text(cRgoal(1), cRgoal(2),'R','Color','red','FontSize',14)
    LRcircles=[cLinit;cLgoal; cRinit; cRgoal];
end