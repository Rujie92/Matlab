function [ flag ] = isNotBridge( G, u, v )
% Input: 
%             G --- Graph
%             u --- Current node
%             v --- next node
%
% Output:
%          flag --- indicator for whether or not a bridge
%    
%   Copyright © 2017, Rujie Wang, All rights reserved

    num1 = DFS(G, u);
    G = changeEdge(G, u, v, 0);
    num2 = DFS(G, u);
    G = changeEdge(G, u, v, 1);
    
    if(num1 == num2)    
        flag = 1;
    else
        flag = 0;
    end
end

