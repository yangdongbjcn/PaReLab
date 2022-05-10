function gm = clusterCells2gmmb(cluster_cells, cfg)
	% final_gmm
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
    
    cluster_num = length(cluster_cells);
   
    gm = clusterCells2normfit(cluster_cells, cfg);
    inits.mu = (gm.mu)';    % D * C
    inits.sigma = gm.Sigma; % D * D * C
    inits.weight = (gm.PComponents)'; % C * 1
    
    data_nd = transferNd(cluster_cells);
    final_gmm = gmmb_em_inits(data_nd, inits, 'components', cluster_num);

    mu = final_gmm.mu;
    sigma = final_gmm.sigma;
    weight = final_gmm.weight;
    
	mu = fixInfinite(mu);
    sigma = fixInfinite(sigma);
    weight = fixInfinite(weight);
    
	gm = gmdistribution(mu', sigma, weight);
end

function data_nd = transferNd(cluster_cells)
    data_nd = [];
    for i = 1 : length(cluster_cells)
        data_nd = [data_nd; cluster_cells{i}];
    end
end

function x = fixInfinite(x)
    tmp = ~isfinite(x);
    x(tmp) = 0;
end
