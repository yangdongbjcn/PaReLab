function dist = DistL1(nd1, nd2, weights)
    dist_mat = abs(nd1 - nd2);
        
    weights = reshape(weights, [length(weights), 1]);
    dist = dist_mat * weights;
end