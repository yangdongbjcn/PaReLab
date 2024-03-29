function [cluster_cells, data_label, center_cd] = KmeansCells(data_nd, cluster_num, cfg)
    % 
	% yangdongbjcn@hotmail.com
	% Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
        
    if exist('cfg.max_iter','var')
        max_iter = cfg.max_iter;
    else
        max_iter = 500;
    end
	
    % options = statset('MaxIter', max_iter);
    % [data_label, center_cd] = kmeans(data_nd, cluster_num, 'options', options, 'emptyaction', 'drop');	
    
    [data_label, center_cd] = KmeansDyang(data_nd, cluster_num, max_iter);
    
    data_label = reshape(data_label, length(data_label),1);
	
	[data_label, xxx] = SortDataLabel(data_label);
    
    cluster_cells = TransDataNdAndLabelToCells(data_nd, data_label);
end