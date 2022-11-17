function isfree = isPathFree(path, Obstacles)
    collided = 1;
    for n = 1:size(path,1)
        collided = ~isFree(path(n,:), Obstacles);
        if collided
            break;
        end
    end
    isfree = ~collided;
end

