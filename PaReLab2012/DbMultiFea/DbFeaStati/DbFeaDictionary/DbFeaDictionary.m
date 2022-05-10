function result = DbFeaDictionary(nd_cells, image_labels, dict_num, regu_type)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    if ~exist('regu_type', 'var')
        regu_type = 1;
    end
    
	data_all = [];
	
	for i = 1 : size(image_labels, 2)
		image_sel = find(image_labels(:, i));
		
		[data_nd, len_arr] = TransCellsToDataNd( nd_cells(image_sel) );
		
		data_all = [data_all; data_nd];
	end
	
	dict_md = GetDict(data_all, dict_num, regu_type);
	
	result = dict_md;
end
