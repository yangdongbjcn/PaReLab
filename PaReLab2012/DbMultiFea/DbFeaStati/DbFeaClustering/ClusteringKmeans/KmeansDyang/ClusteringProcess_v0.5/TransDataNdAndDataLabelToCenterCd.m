function center_cd = TransDataNdAndDataLabelToCenterCd(data_nd, data_label)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %

    labels = unique(data_label);
    for i = 1 : length(labels)
        data_sel = data_label == labels(i);
        cluster_nd = data_nd(data_sel, :);
        center_cd(i, :) = mean(cluster_nd, 1);
    end    
end
