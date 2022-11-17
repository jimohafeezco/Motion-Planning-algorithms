function [CostLSR, pathlsr, D] =  LSR(init, goal, cLinit, cRgoal,r)
qs= init; qg=goal;
v = cRgoal - cLinit;
theta = acos(2*r/norm(v));
alpha = atan2(v(2),v(1));
vn1 = r*[cos(-theta+alpha) sin(-theta+alpha)]';
p1Linit = cLinit + vn1;
p1Rgoal = cRgoal - vn1;
if (isreal(p1Linit))
%%
    C1 = cLinit; 
    aI= Direction(C1, qs);bI = Direction(C1, p1Linit);
    bI = mod(bI-aI,2*pi)+aI; t = linspace(aI,bI);
    xI = C1(1)+r*cos(t);yI = C1(2)+r*sin(t);
    C2= cRgoal;
    aG= Direction(C2, p1Rgoal);bG = Direction(C2, qg);
    aG = mod(aG-bG,2*pi)+bG;t = linspace(aG,bG);
    xG = C2(1)+r*cos(t);yG = C2(2)+r*sin(t);
    line = [p1Linit';p1Rgoal']; 
    pathlsr= [[xI(:), yI(:)];line;[xG(:), yG(:)]];
    d = diff([pathlsr(:,1) pathlsr(:,2)]);
    CostLSR = sum(sqrt(sum(d.*d,2)));
else
        pathlsr= [0,0];
        CostLSR = Inf;
end
D= {p1Linit, p1Rgoal, cLinit, cRgoal};
end