function data_label = TransUCnToDataLabel(u_cn)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
    for i = 1 : size(u_cn, 2)
        [tmp,data_label(i)] = max(u_cn(:, i));
    end
end