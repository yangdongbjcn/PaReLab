function result = DbFeaDimreduction(nd_cells, image_labels, dim, varargin)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
	for i = 1 : size(image_labels, 2)
		image_sel = find(image_labels(:, i));
		
		[data_nd, len_arr] = TransCellsToDataNd( nd_cells(image_sel) );
		
		[data_nr, trans_mat_dr] = ndDimReduction(data_nd, dim, 'PcaShao');
		
		result{i}{1} = data_nr;
        result{i}{2} = trans_mat_dr;
	end
end