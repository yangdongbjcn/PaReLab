function [cluster_cells, data_label, center_cd] = FuzzyKmeansCells(data_nd, cluster_num, cfg)
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
	
    % options =  [NaN, max_iter, NaN, NaN]; % [2.0, max_iter, 1e-5, 1];
    % [center_cd, u_cn] = fcm(data_nd, cluster_num, options);
	% data_label = TransUCnToDataLabel(u_cn);
    
    [data_label, center_cd, u_cn] = FuzzyKmeansDyang(data_nd, cluster_num, max_iter);
    
    data_label = reshape(data_label, length(data_label),1);
	
	[data_label, xxx] = SortDataLabel(data_label);
    
    cluster_cells = TransDataNdAndLabelToCells(data_nd, data_label);
    
%     [center_cd, center_label] = TransDataNdAndDataLabelToCenterCd(data_nd, data_label);
%     center_cd = data_nd(center_label, :);
end