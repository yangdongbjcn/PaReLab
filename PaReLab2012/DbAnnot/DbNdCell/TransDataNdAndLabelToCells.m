function cluster_cells = TransDataNdAndLabelToCells(data_nd, data_label)
    % 
	% yangdongbjcn@hotmail.com
	% Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %

    tmp1 = unique(data_label);
    cluster_num = length(tmp1);
    for t_c = 1 : cluster_num
        tmp1 = data_label == t_c;
        tmp2 = data_nd(tmp1,:);
        cluster_cells{t_c} = tmp2;
    end
end