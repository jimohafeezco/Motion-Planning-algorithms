function [inc] = CollisionFree2D(p1, p2,A) 
dt =.5;
inp=[];
theta = atan2(p2(1,2)-p1(1,2),p2(1,1)-p1(1,1));
i_comp = dt * cos(theta); j_comp = dt * sin(theta);
deltadist = [i_comp,j_comp];
i=0;
        while(1)
            points(i+1,1) = p1(1,1) + i_comp * i;
            points(i+1,2) = p1(1,2) + j_comp * i;
            i = i+1;
            if(abs(p1+i*deltadist-p2)<=abs(deltadist))
                break;
            end
        end
        R = size(points,1);
    for m = 1:R
        xq= points(m,1); yq= points(m,2);
%             plot(xq,yq,'r*')
        [inP] = isinterior(A, xq,yq) ;
        inp =[inp;inP];
        if   ismember(inp,1)
            inc=0;
        else
            inc=1;
        end
    end
end