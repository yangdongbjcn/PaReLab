function new_cells = TransCellsToCellMat(nd_cells, len_arr, cfg)
    if ~exist('cfg', 'var')
        cfg = 2;
    end
    
    switch cfg
        case 1
            for i = 1 : size(nd_cells, 2)
                new_cells(:, i) = TransDataNdAndLengthsToCells(nd_cells{1, i}, len_arr);
            end
        case 2
            for i = 1 : size(nd_cells, 1)
                t2 = TransDataNdAndLengthsToCells(nd_cells{i, :}, len_arr);
                new_cells(i, :) = t2';
            end
    end
end