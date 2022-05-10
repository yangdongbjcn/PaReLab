function [data_nd, len_cells] = TransHierCellsToDataNd(nd_cells)
    data_nd = [];
    for iLabel = 1 : length(nd_cells)
        for iImage = 1 : length(nd_cells{iLabel})
            data_nd = [data_nd; nd_cells{iLabel}{iImage}];
            len_cells{iLabel}(iImage) = size(nd_cells{iLabel}{iImage}, 1);
        end
    end
end