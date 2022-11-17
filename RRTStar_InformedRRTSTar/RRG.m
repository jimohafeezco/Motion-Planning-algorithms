%%
%function G = RRG(s,g,n,A,G)
%%Coperative planning
N= G.vertexlist';
E= G.edgelist';
Gr= PGraph(3);
for i= 1:G.n
    Z(i)= randi([50 60])';
%      Z(i)= 60;       
end
N= [N Z'];
for j=1: size(N,1)
    Gr.add_node(N(j,:));
end
ge= G.edgelist';
E= rmmissing(E);
for k=1:size(E,1)
    if ~isnan(E)
        Gr.add_edge(E(k,1), E(k,2));
    end
end

clear i j k
% figure (3)
% ax = axes('XLim',[-10 310],'YLim',[-10 310],'ZLim',[0 100]);
% hold on

%% 
stepsize = 20;
% Gr.add_node(N(1,:));
% Gr.setvdata(1,{0,0});
for i = 1:G.n
%         Gr.add_node(N(i,:));
        [D,W] = Gr.distances(Gr.coord(i)');
        RRTx_r = RRTx_radius(Gr, stepsize,A);
%         RRTx_r = stepsize;
        X_near = W(D<RRTx_r);
        for j = 1:length(X_near)
            x_m= X_near(j);
            I = find(ge(:, 1) == i & ge(:, 2) == x_m);
            J=find(ge(:, 1) == x_m & ge(:, 2) ==  i );
            if ~isempty(I)
%                 Gr.add_edge(i, x_m);
                Gr.add_edge(x_m,i);
                X_m = Gr.coord(x_m)';ii= Gr.coord(i)';
                plot3([ii(1), X_m(1)], [ii(2), X_m(2)],[ii(3), X_m(3)], '-k', 'LineWidth', 0.5);
                drawnow
            end
            if ~isempty(J)
                Gr.add_edge(i, x_m);
%                 Gr.add_edge(x_m,i);
                X_m = Gr.coord(x_m)';ii= Gr.coord(i)';
                plot3([ii(1), X_m(1)], [ii(2), X_m(2)],[ii(3), X_m(3)], '-r', 'LineWidth', 0.5);
                drawnow
            end
            
            if isempty(I) && isempty(J) && i~= x_m
            [inc] = CFRRG(Gr.coord(i)', Gr.coord(x_m)', Ax) ;
                    if  inc==0 
                            Gr.add_edge(i, x_m);
                            Gr.add_edge(x_m,i);
%                             X_m = Gr.coord(x_m)';ii= Gr.coord(i)';
%                             plot3([ii(1), X_m(1)], [ii(2), X_m(2)],[ii(3), X_m(3)], '-g', 'LineWidth', 0.5);
                            drawnow
                    end
            end
        end
end


%%
% figure(3)
% plot(A)
% hold on
Gr.plot;
g= [g 55];
goal= Gr.closest(g);
% path = Astarplanner(Gr,s, goal)
path = A_star(Gr, 1, goal);
% % xc= G.vdata(goal)
% % path = [goal];
% % while goal ~= 1
% %     goal = G.vdata(goal);
% %     goal= goal{2};
% %     path= [path;goal];
% % end
 Path = Gr.vertexlist(:,path)';
% % plot(A)
% % hold on
 plot3(Path(:,1), Path(:,2),Path(:,3), 'r-', 'Linewidth', 5)
% title(['RRTx_3D at n = ',num2str(n)])
% % end