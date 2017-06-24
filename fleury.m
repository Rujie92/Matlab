function [ W T ] = fleury( x, G, u, start, W, T, vidObj1, vidObj2)
% Input: 
%             x --- Locations of cities
%             G --- Graph
%             u --- Current node
%         start --- Start node
%             W --- Eularian walk
%             T --- TSP tour
%       vidObj1 --- Recording 1
%       vidObj2 --- Recording 1
%
% Output:
%             W --- Eularian walk
%             T --- TSP tour
%    
%   Copyright © 2017, Rujie Wang, All rights reserved

    T = [T u];
    figure(1)
    mark_current = plot(x(u,1), x(u,2), 'ro', 'MarkerSize',14);%%
    writeVideo(vidObj1, getframe(gcf));
    
    neigh = find( G(u,:) > 0 );
    
    mark_neigh = plot(x(neigh,1), x(neigh,2), 'co','LineWidth',2);%%
    writeVideo(vidObj1, getframe(gcf));
    
    if (length(neigh) == 1) 
        plot(x(u,1), x(u,2), 'ro', 'LineWidth', 2);%%
        delete(mark_current);%%
        writeVideo(vidObj1, getframe(gcf));
        plot([x(u,1) x(neigh,1)], [x(u,2) x(neigh,2)], 'r-');%%
        writeVideo(vidObj1, getframe(gcf));
        while( G(u,neigh) == 1 ) % come back from a branch
           G = changeEdge(G, u, neigh, 0);
           plot(x(u,1), x(u,2), 'ko', 'LineWidth', 2);%%
           plot([x(u,1) x(neigh,1)], [x(u,2) x(neigh,2)], 'k-');%%
           mark_neigh = plot(x(neigh,1), x(neigh,2), 'co','LineWidth',2);%%
           writeVideo(vidObj1, getframe(gcf));
           figure(2)
           hold on
           [i,j] = find(G == -1);
           index = [j i];
           plot(index(:,2),index(:,1), 'w*');
           hold off
           writeVideo(vidObj2, getframe(gcf));
           figure(1)
           hold on
           u = neigh;
           neigh = find( G(u,:) > 0 );
        end
        if(neigh)
            delete(mark_neigh);%%
            mark_current = plot(x(u,1), x(u,2), 'ro', 'MarkerSize',14);%%
            mark_neigh = plot(x(neigh,1), x(neigh,2), 'co','LineWidth',2);%%
            delete(mark_neigh);%%
            delete(mark_current);%%
            writeVideo(vidObj1, getframe(gcf));
        end
    end
    
    for k = 1 : 1 :length(neigh)
        v = neigh(k);
        W = [W v];
        if(G(u, v) > 0 && isNotBridge(G, u, v)) % do not separate the graph
            plot([x(u,1) x(v,1)], [x(u,2) x(v,2)], 'r-');%%
            delete(mark_neigh)%%
            plot(x(u,1), x(u,2), 'ro', 'LineWidth', 2);%%
            delete(mark_current);%%
            writeVideo(vidObj1, getframe(gcf));
            G1 = changeEdge(G, u, v, 0);
            
            figure(2) 
            hold on
            [i, j] = find(G ~= G1);
            if(G1(j(1,1),i(1,1)) == 1)
                plot(j(1,1), i(1,1),'r*');
                plot(j(2,1), i(2,1),'r*');
                hold off
                writeVideo(vidObj2, getframe(gcf));
            end
            
            [W T] = fleury(x, G1, v, start, W, T, vidObj1, vidObj2);
                return
        end
    end
    
end

