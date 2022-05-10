function new_cells = TransDataNdToCells(data_nd, nd_cells)
    i = 1;
    for iLabel = 1 : length(nd_cells)
        len = size(nd_cells{iLabel}, 1);
        if  ndims(data_nd) == 2
            new_cells{iLabel} = data_nd(i : i + len - 1, :);
        elseif  ndims(data_nd) == 1
            new_cells{iLabel} = data_nd(i : i + len - 1);
        end
        i = i + len;
    end
end