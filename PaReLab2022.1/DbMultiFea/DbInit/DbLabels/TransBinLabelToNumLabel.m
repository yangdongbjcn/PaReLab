function image_numlabels = TransBinLabelToNumLabel(image_labels)
	%
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
		
    t_num = sum(image_labels, 2);
    label_num = max(t_num);
    image_numlabels = zeros(size(image_labels, 1), label_num);
    for i = 1 : size(image_labels, 1)
        t_label = image_labels(i, :);
        t_idx = find(t_label);
        image_numlabels(i, 1:length(t_idx)) = t_idx;
    end
end