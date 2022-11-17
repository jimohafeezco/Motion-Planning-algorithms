function isfree = isFree(q, Obstacles)
isfree = 1;
    numObs= length(Obstacles);
    for n = 1:numObs
       isfree = isfree && (~inpolygon(q(1), q(2), Obstacles{n}(1,:),Obstacles{n}(2,:)));
       if ~isfree
           break;
        end
    end
end