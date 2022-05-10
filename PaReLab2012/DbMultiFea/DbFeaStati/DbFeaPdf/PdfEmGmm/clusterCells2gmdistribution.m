function gm = clusterCells2gmdistribution(cluster_cells, cfg)
	% gm
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
    gm_init.mu = gm.mu;
    gm_init.Sigma = gm.Sigma;
    gm_init.PComponents = gm.PComponents;
    
    data_nd = transferNd(cluster_cells);
    gm = gmdistribution.fit(data_nd, cluster_num, 'Start', gm_init);

    mu = gm.mu;
    sigma = gm.Sigma;
    weight = gm.PComponents;
    
	mu = fixInfinite(mu);
    sigma = fixInfinite(sigma);
    weight = fixInfinite(weight);
    
	gm = gmdistribution(mu, sigma, weight);
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
