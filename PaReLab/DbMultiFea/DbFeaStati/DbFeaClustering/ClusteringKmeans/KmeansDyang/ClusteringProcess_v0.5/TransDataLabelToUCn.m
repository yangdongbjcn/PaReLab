function u_cn = TransDataLabelToUCn(data_label)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
    data_num = length(data_label);
    labels = unique(data_label);
    cluster_num = length(labels);
    
    u_cn = zeros(cluster_num, data_num);
    for i = 1 : data_num
        u_cn(data_label(i), i) = 1;
    end
end