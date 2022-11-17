function Gs = SampleFreeGs(n)
load Obstacles.mat A
Gs = PGraph(2);
xDim = 110;
yDim = 110;
count = 0;
xOffSet = -10;
yOffSet = -10;

while count < n
    x = rand * xDim + xOffSet;
    y = rand * yDim + yOffSet;
    q= [x,y];
    in = isFreep(q,A);
    if in == 0
         Gs.add_node([x,y]);
         count = count +1; 
    end
end                        