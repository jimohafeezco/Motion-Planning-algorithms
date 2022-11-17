function near = Near(G, v, r)
    [d, w] = G.distances(G.coord(v));
    near = w((d<r)&(d>0)); % This is to get all nodes smaller than n and greater than 0
end
