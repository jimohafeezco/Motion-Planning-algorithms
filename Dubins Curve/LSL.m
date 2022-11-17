function [CostLSL, pathlsl, C] = LSL(init, goal, cLinit, cLgoal,r)
v = cLgoal - cLinit;
vOrt = [v(2) -v(1)]';
vOrt = vOrt/(norm(vOrt));
vn1 = r*vOrt;
p1Linit = cLinit + vn1;
p1Lgoal = cLgoal + vn1;
%%
if (isreal(p1Linit))
    C1 = cLinit; 
    aI= Direction(C1, init);bI = Direction(C1, p1Linit);
    bI = mod(bI-aI,2*pi)+aI; t = linspace(aI,bI);
    xI = C1(1)+r*cos(t);yI = C1(2)+r*sin(t);
    C2= cLgoal;
    aG= Direction(C2, p1Lgoal);bG = Direction(C2, goal);
    bG = mod(bG-aG,2*pi)+aG; t = linspace(aG,bG);
    xG = C2(1)+r*cos(t);yG = C2(2)+r*sin(t);
    %%
    line = [p1Linit';p1Lgoal'];
    pathlsl= [[xI(:), yI(:)];line;[xG(:), yG(:)]];
    CostLSL= norm(pathlsl(:,1)-pathlsl(:,2));
%     CostLSL = sum(sqrt(sum(d.*d,2)));
%%
else
        pathlsl= [0,0];
        CostLSL = Inf;
end
C= { p1Linit, p1Lgoal, cLinit, cLgoal};


end