function sim_c = TransSimMatrixDataLabelCenterIToSimC(sim_matrix, data_label, center_i)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2009). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
    labels = unique(data_label);
    cluster_num = length(labels);
	assert(cluster_num == length(center_i));
    
    N = size(sim_matrix, 1);
    sim_c = zeros(N, 1);

    for i = 1 : cluster_num
		data_sel = data_label == labels(i);        
        sim_c(data_sel) = sim_matrix(data_sel, center_i(i));
    end
end