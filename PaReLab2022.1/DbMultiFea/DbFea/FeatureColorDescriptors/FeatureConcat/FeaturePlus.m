function [nd_cells, data_names] = FeaturePlus(data_nd_1, data_name_1, data_nd_2, data_name_2)
	%
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
	[data_nd_1] = data2cell(data_nd_1);
	[data_name_1] = data2cell(data_name_1);
	[data_nd_2] = data2cell(data_nd_2);
	[data_name_2] = data2cell(data_name_2);
	
	nd_cells = {data_nd_1{:}, data_nd_2{:}};
	data_names = {data_name_1{:}, data_name_2{:}};
end

function [data_nd_2] = data2cell(data_nd_1)
	if ~iscell(data_nd_1)
		data_nd_2{1} = data_nd_1;
    else
        data_nd_2 = data_nd_1;
	end	
end