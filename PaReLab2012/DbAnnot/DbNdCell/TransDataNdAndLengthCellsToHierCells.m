function new_cells = TransDataNdAndLengthCellsToHierCells(data_nd, len_cells)
    i = 1;
    for iLabel = 1 : length(len_cells)
        for iImage = 1 : length(len_cells{iLabel});
            len = len_cells{iLabel}(iImage);
            if  ndims(data_nd) == 2
                new_cells{iLabel}{iImage} = data_nd(i : i + len - 1, :);
            elseif  ndims(data_nd) == 1
                new_cells{iLabel}{iImage} = data_nd(i : i + len - 1);
            end
            i = i + len;
        end
    end
end