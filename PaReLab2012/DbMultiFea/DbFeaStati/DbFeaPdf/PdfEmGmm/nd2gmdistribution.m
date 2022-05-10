function gm = nd2gmdistribution(data_nd, cluster_num, cfg)
    % 
	% yangdongbjcn@hotmail.com
	% Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
        
    options = statset('Display','final');
	gm = gmdistribution.fit(data_nd,cluster_num,'Options',options, 'Regularize', 1e-6);
end