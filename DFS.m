function [ num ] = DFS( G, start )
% Input: 
%              G --- Graph
%          start --- start node
%
% Output:
%            num --- number of nodes the start node can reach
%    
%   Copyright © 2017, Rujie Wang, All rights reserved

O = [start];
C = [];
done = 0;

while (~done)

    if (isempty(O))
        done = 1;
        continue;
    end

    
    curnode = O(1,1);
    
    
    C = [C; curnode];
    O = O(1, [2:end]);

    
    neigh = find( G(curnode,:) > 0 );
    
    
    for i=1:length(neigh)

        found = find(C(:,1) == neigh(i),1);
        if (~isempty(found))
            continue;
        end
        
        
        found = find(O(1,:) == neigh(i),1);
        if (isempty(found))
        	O = [O neigh(i)];
        end
    end
end
num = length(C);
end


