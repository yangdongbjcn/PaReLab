function [data_nd, len_arr] = TransCellsToDataNd(nd_cells, cfg)
    if ~exist('cfg', 'var')
        cfg = 1;
    end
    
    switch cfg
        case 1
            nd_cells = reshape(nd_cells, [length(nd_cells), 1]);
            [data_nd, len_arr] = TransCellsToDataNdAndLengths(nd_cells);
        case 2            
            nd_cells = reshape(nd_cells, [1, length(nd_cells)]);
            [data_nd, len_arr] = TransCellsToDataNdAndLengths(nd_cells);
    end
end