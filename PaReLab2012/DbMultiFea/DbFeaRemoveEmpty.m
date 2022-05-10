function result = DbFeaRemoveEmpty(nd_cells, image_labels, varargin)
    empty_sel = zeros(1, length(nd_cells));
    for i = 1 : length(nd_cells)
        data_nd = nd_cells{i};
        if isempty(data_nd)
            empty_sel(i) = 1;
        end
    end
	
    nd_cells = nd_cells(~empty_sel);
    image_labels = image_labels(~empty_sel, :);
    
    result{1} = empty_sel;
	result{2} = nd_cells;
	result{3} = image_labels;
end