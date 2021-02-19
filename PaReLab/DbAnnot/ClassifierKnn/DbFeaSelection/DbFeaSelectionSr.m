function [weights, meanDist] = DbFeaSelectionSr(nd_cells, image_labels, cfg)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %

    if ~exist('cfg', 'var')
		cfg = struct;
    end
    
    if ~isfield('cfg', 'weight_type')
        weight_type = 1;
    end
    
    if ~isfield('cfg', 'weight_lambda')
        weight_lambda = 1;
    end
    
    if ~isfield('cfg', 'feature_group')
        feature_group = [];
    end
    
    [data_nd, inst_len] = TransCellsToDataNd(nd_cells);
    inst_map = BuildInstanceDataMap(inst_len);
    inst_labels = image_labels(inst_map, :);
    [label_order, label_order_map] = TransBinLabelToOrderLabel(inst_labels);
    label_order = reshape(label_order, length(label_order), 1);
    
    % Compute weights
    weights = SrWrapper(data_nd, label_order, weight_lambda, feature_group, weight_type);
end