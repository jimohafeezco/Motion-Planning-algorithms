function [CostRSR, pathrsr, R] = RSR(init, goal, cRinit, cRgoal,r)
v = cRgoal - cRinit;
vOrt = [v(2) -v(1)]';
vOrt = vOrt/(norm(vOrt));
vn2 = -r*vOrt;
p2Rinit = cRinit + vn2;
p2Rgoal = cRgoal + vn2;
%%
if (isreal(p2Rinit))
    C1 = cRinit;
    aI= Direction(C1, init);bI = Direction(C1, p2Rinit);
    aI = mod(aI-bI,2*pi)+bI;t = linspace(aI,bI);
    xI = C1(1)+r*cos(t);yI = C1(2)+r*sin(t);
    C2= cRgoal;
    aG= Direction(C2, p2Rgoal);bG = Direction(C2, goal);
    aG = mod(aG-bG,2*pi)+bG;t = linspace(aG,bG);
    xG = C2(1)+r*cos(t);yG = C2(2)+r*sin(t);
    line = [p2Rinit';p2Rgoal']; 
    pathrsr= [[xI(:), yI(:)];line;[xG(:), yG(:)]];
    d = diff([pathrsr(:,1) pathrsr(:,2)]);
    CostRSR = sum(sqrt(sum(d.*d,2)));
%%
else
        pathrsr= [0,0];
        CostRSR = Inf;
end
R= {p2Rinit, p2Rgoal, cRinit, cRgoal};
end