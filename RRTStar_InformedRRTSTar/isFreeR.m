function [inc] = isFreeR(points, Nodes)
inp=[];
for m = 1:length(points)   
    xq= points(m,1);
    yq= points(m,2);
    [inP] = isinterior(Nodes, xq,yq) ;
    inp =[inp;inP];
    if   ~ismember(inp,1)   
        inc=0;
    else
        inc=1;
    end
end
end