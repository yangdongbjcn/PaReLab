function gm = nd2gmmb(data_nd, cluster_num, cfg)
    % final_gmm
	% weight 1*c
	% mu c*d
	% sigma d*d*c
	% 
	% yangdongbjcn@hotmail.com
	% Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
        
    final_gmm = gmmb_em(data_nd, 'components', cluster_num);
	
	mu = final_gmm.mu;
    sigma = final_gmm.sigma;
    weight = final_gmm.weight;
    
	mu = fixInfinite(mu);
    sigma = fixInfinite(sigma);
    weight = fixInfinite(weight);
    
	gm = gmdistribution(mu', sigma, weight);
end

function x = fixInfinite(x)
    tmp = ~isfinite(x);
    x(tmp) = 0;
end