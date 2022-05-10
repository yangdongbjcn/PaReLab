function [data_nd, len_arr] = TransCellsToDataNdAndLengths(nd_cells)
    d1 = size(nd_cells, 1);
    d2 = size(nd_cells, 2);
    assert((d1==1)||(d2==1));

    for iLabel = 1 : length(nd_cells)
        if (d1==1)
            len_arr(iLabel) = size(nd_cells{iLabel}, 2);
        else
            len_arr(iLabel) = size(nd_cells{iLabel}, 1);
        end
    end
    
    data_nd = cell2mat(nd_cells);
end