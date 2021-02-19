function sim_c = TransSimMatrixIdxToSimC(sim_matrix, idx)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2009). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
    center_i = unique(idx);
    cluster_num = length(center_i);
    
    N = size(sim_matrix, 1);
    sim_c = zeros(N, 1);

    for i = 1 : cluster_num
		data_sel = idx == center_i(i);        
        sim_c(data_sel) = sim_matrix(data_sel, center_i(i));
    end
end