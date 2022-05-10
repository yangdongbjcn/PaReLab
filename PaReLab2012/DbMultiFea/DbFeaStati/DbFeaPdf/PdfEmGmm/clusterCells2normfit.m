function gm = clusterCells2normfit(cluster_cells, cfg)
	% gmm
	% weight 1*c
	% mu c*d
	% sigma d*d*c
	% 
	% yangdongbjcn@hotmail.com
	% Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
	if ~exist('cfg','var')
        cfg = [];
    end

    D = size(cluster_cells{1},2);    % dimensions
    C = length(cluster_cells);
	
	mu = zeros(C, D);
	sigma = zeros(D, D, C);
	weight = zeros(1, C);
    
    if C == 1
        mu = mean(cluster_cells{1}, 1);
        sigma = cov(cluster_cells{1});
        sigma = fixInfinite(sigma);
        sigma = gmmb_covfixer(sigma);
        weight = 1;
        gm = gmdistribution(mu, sigma, weight);
        return;
    end;
    
    for t_c = 1 : C
        data_nd = cluster_cells{t_c};
		[mu(t_c, :),sigma(:,:,t_c)] = switchNormfit(data_nd);
        sigma(:,:,t_c) = fixInfinite(sigma(:,:,t_c));
        sigma(:,:,t_c) = gmmb_covfixer(sigma(:,:,t_c));
        weight(1, t_c) = size(data_nd, 1);
    end
    weight = weight / sum(weight);

	mu = fixInfinite(mu);
    sigma = fixInfinite(sigma);
    weight = fixInfinite(weight);
    
	gm = gmdistribution(mu, sigma, weight);
end

function [mu,sigma] = switchNormfit(data_nd)			
	if size(data_nd,1) == 1
		mu = data_nd;
		sigma = 1;
		return;
	end
	cfg = 'normfit';
	switch cfg
		case 'normfit'	
			[mu,sigma,muci,sigmaci] = normfit(single(data_nd));
			sigma = diag(sigma); % standard variance to covariance
		case 'mean_cov'	
			mu = mean(data_nd,1);
			sigma = cov(feature_nd);
	end
end

function x = fixInfinite(x)
    tmp = ~isfinite(x);
    x(tmp) = 0;
end