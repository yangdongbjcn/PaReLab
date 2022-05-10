function center_i = TransDataNdAndDataLabelAndCenterCdToCenterI(data_nd, data_label, center_cd)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %

    labels = unique(data_label);
    
    for i = 1 : length(labels)
        data_sel = find(data_label == labels(i));
        
        tmp1 = findCenterLabelOneClass(data_nd(data_sel, :), center_cd(i, :));
        center_i(i) = data_sel(tmp1);
    end
end

function center_i = findCenterLabelOneClass(data_nd, center_1d)
    diff_nd = single(data_nd) - single(repmat(center_1d, size(data_nd, 1), 1));
    tmp_var = sum(diff_nd .^ 2, 2);
    [C, center_i] = min(tmp_var);
end