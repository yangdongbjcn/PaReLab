function new_cells = TransDataNdToHierCells(data_nd, nd_cells)
    i = 1;
    for iLabel = 1 : length(nd_cells)
        for iImage = 1 : length(nd_cells{iLabel})
            len = size(nd_cells{iLabel}{iImage}, 1);
            if  ndims(data_nd) == 2
                new_cells{iLabel}{iImage} = data_nd(i : i + len - 1, :);
            elseif  ndims(data_nd) == 1
                new_cells{iLabel}{iImage} = data_nd(i : i + len - 1);
            end
            i = i + len;
        end
    end
end