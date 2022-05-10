function [dict_md, u_cn] = GetDict(data_nd, dict_num, regu_type)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    if ~exist('regu_type', 'var')
        regu_type = 1;
    end
	
	% 0 -- JEC; 1 -- lasso; 2 -- group lasso; 5 -- Least Square; 
    % 6 -- L2 regularization
    switch regu_type 
		case 1
			[dict_md, u_cn] = GetDictLasso(data_nd, dict_num);
		case 2
			[dict_md, u_cn] = GetDictLassoGroup(data_nd, dict_num);
		case 5
			[dict_md, u_cn] = GetDictLeastSquare(data_nd, dict_num);
		case 6
			[dict_md, u_cn] = GetDictL2Reg(data_nd, dict_num);
	end
end
