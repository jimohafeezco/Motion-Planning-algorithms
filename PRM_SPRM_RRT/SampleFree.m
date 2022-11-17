function G = SampleFree(n, O)
    G = PGraph();
    count = 0;
    while count < n
        qx = rand * 10;
        qy = rand * 10;
        q=[qx; qy];
        if isFree(q,O)
            G.add_node(q);
            count = count + 1;
        end
    end
end