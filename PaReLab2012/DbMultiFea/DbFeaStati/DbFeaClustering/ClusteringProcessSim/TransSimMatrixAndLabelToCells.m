function sim_matrix_cells = TransSimMatrixAndLabelToCells(sim_matrix, data_label)
    % 
	% yangdongbjcn@hotmail.com
	% Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %

    tmp1 = unique(data_label);
    cluster_num = length(tmp1);
    for t_c = 1 : cluster_num
        tmp1 = data_label == t_c;
        tmp2 = sim_matrix(tmp1,tmp1);
        sim_matrix_cells{t_c} = tmp2;
    end
end