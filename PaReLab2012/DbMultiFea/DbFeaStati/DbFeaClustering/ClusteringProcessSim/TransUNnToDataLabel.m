function [data_label, center_i] = TransUNnToDataLabel(u_nn)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	one_exemplar_constraint = sum(u_nn, 2);
	assert(all(one_exemplar_constraint==1));
	
	center_i = find(sum(u_nn, 1));
	
    data_num = size(u_nn, 1);
	
    for i = 1 : data_num
        idx(i) = find(u_nn(i, :));
    end
	[data_label, center_i] = SortDataLabel(idx);
end