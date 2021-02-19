function image_labels = TransOrderLabelToBinLabel(imageLabelOrder, mapLabelOrder)
	%
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
	image_labels = mapLabelOrder(imageLabelOrder, :);
end