function [new_cells, len_arr] = TransCellMatToCells(nd_cells, cfg)
    if ~exist('cfg', 'var')
        cfg = 2;
    end
    
    if length(nd_cells) == 1
       new_cells = nd_cells;
       len_arr = 1;
       return;
    end
    
    switch cfg
        case 1
            for i = 1 : size(nd_cells, 2)
                [new_cells{1, i}, len_arr] = TransCellsToDataNdAndLengths(nd_cells(:, i));
            end
        case 2
            for i = 1 : size(nd_cells, 1)
                [new_cells{i, 1}, len_arr] = TransCellsToDataNdAndLengths(nd_cells(i, :));
            end
    end
end