function [points] = discretizeLine(p1, p2) 
stepsize = .01;
dt = stepsize;
theta = atan2(p2(1,2)-p1(1,2),p2(1,1)-p1(1,1));
i_comp = dt * cos(theta);
j_comp = dt * sin(theta);
deltadist = [i_comp,j_comp];
i=0;
    while(1)
        points(i+1,1) = p1(1,1) + i_comp * i;
        points(i+1,2) = p1(1,2) + j_comp * i;
        i = i+1;
            if(abs(p1+i*deltadist-p2)<=abs(deltadist)) %((abs(p1(1,1) + i_comp * i-p2(1,1)) < abs(i_comp))||(abs(p1(1,2)+j_comp*i-p2(1,2))<abs(j_comp)))
            break;
            end
    end
end