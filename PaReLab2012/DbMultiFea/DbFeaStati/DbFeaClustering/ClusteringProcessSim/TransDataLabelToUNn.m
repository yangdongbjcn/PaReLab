function u_nn = TransDataLabelToUNn(data_label, center_i)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
    data_num = length(data_label);
    
    u_nn = zeros(data_num, data_num);
	
    for i = 1 : data_num
        u_nn(i, center_i(data_label(i))) = 1;
    end
end