function [CostRSL, pathrsl, L]= RSL(init, goal, cRinit, cLgoal,r)
v = cLgoal - cRinit;
theta = acos(2*r/norm(v));
alpha = atan2(v(2),v(1));
vn1 = r*[cos(alpha+theta) sin(alpha+theta)]';
p1Rinit = cRinit + vn1;
p1Lgoal = cLgoal - vn1;
        %%
if (isreal(p1Rinit))
    C1 = cRinit;
    aI= Direction(C1, init);bI = Direction(C1, p1Rinit);
    aI = mod(aI-bI,2*pi)+bI; t = linspace(aI,bI);
    xI = C1(1)+r*cos(t);yI = C1(2)+r*sin(t);
    C2= cLgoal;
    aG= Direction(C2, p1Lgoal);bG = Direction(C2, goal);
    bG = mod(bG-aG,2*pi)+aG; t = linspace(aG,bG);
    xG = C2(1)+r*cos(t);yG = C2(2)+r*sin(t);
    %%

    line = [p1Rinit';p1Lgoal']; 
    pathrsl= [[xI(:), yI(:)];line;[xG(:), yG(:)]];
    d = diff([pathrsl(:,1) pathrsl(:,2)]);
    CostRSL = sum(sqrt(sum(d.*d,2)));
else
        pathrsl= [0,0];
        CostRSL = Inf;
end
L= {p1Rinit, p1Lgoal, cRinit, cLgoal};

end