function dist = DistMaxHausdorff(n1d, n2d)
	dist = max(distMaxMin(n1d, n2d), distMaxMin(n2d, n1d));
end

function[dist] = distMaxMin(n1d, n2d) 
	n1 = size(n1d, 1); 
	n2 = size(n2d, 1); 
	dim= size(n1d, 2); 
	for k = 1:n1 
		C = ones(n2, 1) * n1d(k, :); 
		D = (C-n2d) .* (C-n2d); 
		D = sqrt(D * ones(dim,1)); 
		dist(k) = min(D); 
	end
	dist = max(dist);
end