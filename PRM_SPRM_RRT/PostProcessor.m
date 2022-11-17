function pathm = PostProcessor(O,path)
pathm = path(1, :); m = 1; n = m; m0 = m; f = linspace(0,1,500)'; 
while(n < size(path,1))
    p1 = pathm(end,:);  
    n = m + 1; itsfree = 1;
    while(n < size(path,1))
        p2 = path(n,:);
        itsfree = isFree(ones(size(f))*p1 + f*(p2-p1), O);
        if(~itsfree)
            break;
        else
            m = n;
            n = n + 1;
        end
    end
    if(n - m0) > 1
        pathm = [pathm; path(m,:)]; 
    else
        pathm = [pathm; path(n,:)]; m = n; 
    end
    m0 = m;
end
pathm = [pathm; path(end,:)];
    