function dist = DistL2(nd1, nd2, weights)
    dist_mat = abs(nd1 - nd2);
    dist2_mat = dist_mat.^2;
        
    weights = reshape(weights, [length(weights), 1]);
    dist2 = dist2_mat * weights;

	dist = dist2;
    % dist = sqrt(dist2);
end