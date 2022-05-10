function dist = DistKl(nd1, nd2, weights)
    id1 = find(nd1 == 0);
	id2 = find(nd2 == 0);
	nd1(id1) = 10^-5;
	nd2(id2) = 10^-5;
	dist = nd2.*(log2(nd2) - log2(nd1));
	
    weights = reshape(weights, [length(weights), 1]);
    dist = dist * weights;
end