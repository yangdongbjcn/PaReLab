function gm = nd2gm(data_nd, cluster_num, cfg)
    % final_gmm
	% weight 1*c
	% mu c*d
	% sigma d*d*c
	% 
	% yangdongbjcn@hotmail.com
	% Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
	try
		gm = nd2gmdistribution(data_nd, cluster_num);
	catch
		try
			gm = nd2gmmb(data_nd, cluster_num);
		catch
			[cluster_cells, data_label, center_cd] = KmeansCells(data_nd, cluster_num);
			gm = clusterCells2normfit(cluster_cells);
		end
	end
end

function x = fixInfinite(x)
    tmp = ~isfinite(x);
    x(tmp) = 0;
end