function [data_nd, n_group] = FeatureConcat(nd_cells)
	%
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
    data_nd = [];
    n_group = [];
    for i = 1 : length(nd_cells)
        num = size(nd_cells{i}, 2);
        n_group = [n_group, ones(1, num)*i];
        data_nd = [data_nd, nd_cells{i}];
    end
	[data_bounds, data_nd] = GetBounds(data_nd, n_group);
end
