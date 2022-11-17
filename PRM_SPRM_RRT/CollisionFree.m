function collision = CollisionFree(G, v, u, step, O)
    direction = (G.coord(v)-G.coord(u))/norm(G.coord(v)-G.coord(u));
    position = step;
    collision = false;
    while (position < norm(G.coord(v)-G.coord(u))) 
        if ~isFree(G.coord(u)+direction*position,O)
            return
        end
        position = position + step;
    end
    collision = true;
end