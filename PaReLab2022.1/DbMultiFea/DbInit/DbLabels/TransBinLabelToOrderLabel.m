function [imageLabelOrder, mapLabelOrder] = TransBinLabelToOrderLabel(image_labels)
	%
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
		
    img_num = size(image_labels, 1);
    
    for i = 1 : img_num
        t_label = image_labels(i, :);
        t_str = num2str(t_label);
		A(i) = bin2dec(t_str);
    end
	
	[b, m, n] = unique(A); 	% b = A(m), A = b(n);
	mapLabelOrder = image_labels(m, :);
	imageLabelOrder = n;
end