function weights = SelFea(train_cells, train_labels, dim_sel)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    % feature selection
    [train_nnd, dim_len_train] = TransCellMatToCells(train_cells, 2);
    dim_num = sum(dim_len_train);
    
    switch dim_sel
        case 0
            weights = ones(1, dim_num);
        case 1
            weights = DbFeaSelection(train_nnd, train_labels);
            weights = reshape(weights, 1, length(weights));
    end
end