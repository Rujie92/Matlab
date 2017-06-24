function [ G ] = changeEdge( G, u, v, flag )
% Input: 
%             G --- Graph
%             u --- Current node
%             v --- next node
%          flag --- indicator for adding of deleting an edge
%
% Output:
%             G --- Eularian walk
%    
%   Copyright © 2017, Rujie Wang, All rights reserved
    if(~flag)
        if(G(u,v) == 2)
            G(u,v) = 1;
            G(v,u) = 1;
        elseif (G(u,v) == 1)
            G(u,v) = -1;
            G(v,u) = -1;
        end
        
    else
        if(G(u,v) == -1)
            G(u,v) = 1;
            G(v,u) = 1;
        elseif (G(u,v) == 1)
            G(u,v) = 2;
            G(v,u) = 2;
        end
    end

end

