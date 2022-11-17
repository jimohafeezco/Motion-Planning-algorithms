function path = BFSpath(bitmap, StartPt)
[s1, s2] = size(bitmap); Currentpt = StartPt; path = Currentpt;  
currentval = bitmap(Currentpt(1), Currentpt(2));
while(currentval>2)
    nghbrs = ones(4,1)*Currentpt+ [-1,0;0,1;1,0;0,-1];%[-1,0; -1,1; 0,1; 1,1;1,0;1,-1;0,-1;-1,-1];
    nghbrs = nghbrs(nghbrs(:,1) >= 1 & nghbrs(:,1) <= s1 & nghbrs(:,2)>=1 & nghbrs(:,2)<= s2, :);
    idx = sub2ind([s1, s2], nghbrs(:,1), nghbrs(:,2));
    vals = bitmap(idx); [currentval,id] = min(vals);
    Currentpt = nghbrs(id,:);
    path = [path;Currentpt];
end
end